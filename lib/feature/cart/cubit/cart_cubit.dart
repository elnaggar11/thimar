import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/cart_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState()) {
    getCart();
  }

  Future<void> getCart() async {
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: APIconst.cart);
    
    if (response.success) {
      final cartData = CartModel.fromJson(response.data['data']);
      emit(state.copyWith(state: RequestState.done, cartData: cartData));
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
    }
  }

  // Placeholder for update quantity, delete item, apply coupon if needed
}
