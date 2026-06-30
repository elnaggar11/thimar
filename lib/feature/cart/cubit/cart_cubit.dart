import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/models/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  final Map<String, Timer> _debounceTimers = {};

  CartCubit() : super(CartState()) {
    getCart();
  }

  Future<void> getCart() async {
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: APIconst.cart);

    if (response.success) {
      final cartData = CartModel.fromJson(response.data);
      emit(state.copyWith(state: RequestState.done, cartData: cartData));
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
    }
  }

  Future<bool> addToCart({
    required String productId,
    required int amount,
  }) async {
    final response = await ServerGate.i.sendToServer(
      url: APIconst.cart,
      body: {
        'product_id': int.tryParse(productId) ?? productId,
        'amount': amount,
      },
    );

    if (response.success) {
      FlashHelper.showToast(response.msg, type: MessageType.success);
      getCart();
      return true;
    } else {
      FlashHelper.showToast(response.msg, type: MessageType.fail);
      return false;
    }
  }

  Future<void> applyCoupon(String code) async {
    emit(state.copyWith(applyCouponState: RequestState.loading));
    final response = await ServerGate.i.sendToServer(
      url: APIconst.applyCoupon,
      formData: {'code': code},
    );

    if (response.success) {
      emit(state.copyWith(applyCouponState: RequestState.done));
      FlashHelper.showToast(response.msg, type: MessageType.success);
      getCart();
    } else {
      emit(
        state.copyWith(
          applyCouponState: RequestState.error,
          message: response.msg,
        ),
      );
      FlashHelper.showToast(response.msg, type: MessageType.fail);
    }
  }

  void updateCartItemLocal({required String cartItemId, required int amount}) {
    final cart = state.cartData;
    if (cart != null) {
      final index = cart.items.indexWhere(
        (element) => element.id == cartItemId,
      );
      if (index != -1) {
        // Update local state for immediate UI reflection
        cart.items[index].amount = amount;
        emit(state.copyWith(cartData: cart));

        // Cancel any existing timer for this item
        _debounceTimers[cartItemId]?.cancel();

        // Start a new timer for 750 milliseconds (3/4 second)
        _debounceTimers[cartItemId] = Timer(
          const Duration(milliseconds: 750),
          () {
            updateCartItem(cartItemId: cartItemId, amount: amount);
          },
        );
      }
    }
  }

  Future<bool> updateCartItem({
    required String cartItemId,
    required int amount,
  }) async {
    final response = await ServerGate.i.putToServer(
      url: APIconst.updateCartItem(cartItemId),
      body: {'amount': amount},
    );

    if (response.success) {
      // Refresh the cart
      getCart();
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteCartItem({required String cartItemId}) async {
    final response = await ServerGate.i.deleteFromServer(
      url: APIconst.deleteCartItem(cartItemId),
    );

    if (response.success) {
      getCart();
      return true;
    } else {
      return false;
    }
  }
}
