part of 'orders_cubit.dart';

class OrdersState {
  final RequestState currentOrdersState;
  final RequestState finishedOrdersState;
  final RequestState storeOrderState;
  final RequestState orderDetailsState;
  final RequestState cancelOrderState;
  final String message;
  final ErrorType errorType;
  final List<OrderModel> currentOrders;
  final List<OrderModel> finishedOrders;
  final OrderModel? orderDetails;

  const OrdersState({
    this.currentOrdersState = RequestState.initial,
    this.finishedOrdersState = RequestState.initial,
    this.storeOrderState = RequestState.initial,
    this.orderDetailsState = RequestState.initial,
    this.cancelOrderState = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
    this.currentOrders = const [],
    this.finishedOrders = const [],
    this.orderDetails,
  });

  OrdersState copyWith({
    RequestState? currentOrdersState,
    RequestState? finishedOrdersState,
    RequestState? storeOrderState,
    RequestState? orderDetailsState,
    RequestState? cancelOrderState,
    String? message,
    ErrorType? errorType,
    List<OrderModel>? currentOrders,
    List<OrderModel>? finishedOrders,
    OrderModel? orderDetails,
  }) {
    return OrdersState(
      currentOrdersState: currentOrdersState ?? this.currentOrdersState,
      finishedOrdersState: finishedOrdersState ?? this.finishedOrdersState,
      storeOrderState: storeOrderState ?? this.storeOrderState,
      orderDetailsState: orderDetailsState ?? this.orderDetailsState,
      cancelOrderState: cancelOrderState ?? this.cancelOrderState,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
      currentOrders: currentOrders ?? this.currentOrders,
      finishedOrders: finishedOrders ?? this.finishedOrders,
      orderDetails: orderDetails ?? this.orderDetails,
    );
  }
}
