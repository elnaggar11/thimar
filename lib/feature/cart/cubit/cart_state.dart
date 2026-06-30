import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/cart_model.dart';

class CartState {
  final RequestState state;
  final RequestState applyCouponState;
  final String message;
  final CartModel? cartData;

  CartState({
    this.state = RequestState.initial,
    this.applyCouponState = RequestState.initial,
    this.message = '',
    this.cartData,
  });

  CartState copyWith({
    RequestState? state,
    RequestState? applyCouponState,
    String? message,
    CartModel? cartData,
  }) {
    return CartState(
      state: state ?? this.state,
      applyCouponState: applyCouponState ?? this.applyCouponState,
      message: message ?? this.message,
      cartData: cartData ?? this.cartData,
    );
  }
}
