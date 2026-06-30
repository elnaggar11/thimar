import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/order_model.dart';
import 'package:thimar/core/utils/app_constant.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(const OrdersState());

  Future<void> getCurrentOrders() async {
    emit(state.copyWith(currentOrdersState: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: APIconst.currentOrders);
    if (response.success) {
      final List<OrderModel> currentOrders = List<OrderModel>.from(
          (response.data['data'] as List).map((e) => OrderModel.fromJson(e)));
      emit(state.copyWith(
        currentOrdersState: RequestState.done,
        currentOrders: currentOrders,
      ));
    } else {
      emit(state.copyWith(
        currentOrdersState: RequestState.error,
        message: response.msg,
        errorType: response.errType,
      ));
    }
  }

  Future<void> getFinishedOrders() async {
    emit(state.copyWith(finishedOrdersState: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: APIconst.finishedOrders);
    if (response.success) {
      final List<OrderModel> finishedOrders = List<OrderModel>.from(
          (response.data['data'] as List).map((e) => OrderModel.fromJson(e)));
      emit(state.copyWith(
        finishedOrdersState: RequestState.done,
        finishedOrders: finishedOrders,
      ));
    } else {
      emit(state.copyWith(
        finishedOrdersState: RequestState.error,
        message: response.msg,
        errorType: response.errType,
      ));
    }
  }

  Future<void> storeOrder({
    required int addressId,
    required String date,
    required String time,
    required String payType,
    String? note,
  }) async {
    emit(state.copyWith(storeOrderState: RequestState.loading));
    final response = await ServerGate.i.sendToServer(
      url: APIconst.storeOrder,
      formData: {
        'address_id': addressId,
        'date': date,
        'time': time,
        'pay_type': payType,
        if (note != null && note.isNotEmpty) 'note': note,
      },
    );
    if (response.success) {
      emit(state.copyWith(
        storeOrderState: RequestState.done,
      ));
    } else {
      emit(state.copyWith(
        storeOrderState: RequestState.error,
        message: response.msg,
        errorType: response.errType,
      ));
    }
  }

  Future<void> getOrderDetails(int id) async {
    emit(state.copyWith(orderDetailsState: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: APIconst.orderDetails(id));
    if (response.success) {
      final OrderModel orderDetails = OrderModel.fromJson(response.data['data']);
      emit(state.copyWith(
        orderDetailsState: RequestState.done,
        orderDetails: orderDetails,
      ));
    } else {
      emit(state.copyWith(
        orderDetailsState: RequestState.error,
        message: response.msg,
        errorType: response.errType,
      ));
    }
  }

  Future<void> cancelOrder(int id) async {
    emit(state.copyWith(cancelOrderState: RequestState.loading));
    final response = await ServerGate.i.sendToServer(url: APIconst.cancelOrder(id));
    if (response.success) {
      emit(state.copyWith(cancelOrderState: RequestState.done));
    } else {
      emit(state.copyWith(
        cancelOrderState: RequestState.error,
        message: response.msg,
        errorType: response.errType,
      ));
    }
  }
}
