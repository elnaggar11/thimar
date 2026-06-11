part of 'orders_cubit.dart';

class OrdersState {
  final RequestState state;
  final String message;
  final ErrorType errorType;

  OrdersState({
    this.state = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
  });

  OrdersState copyWith({
    RequestState? state,
    String? message,
    ErrorType? errorType,
  }) {
    return OrdersState(
      state: state ?? this.state,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
    );
  }
}
