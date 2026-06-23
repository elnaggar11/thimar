import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/notification_model.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsState()) {
    getNotifications();
  }

  Future<void> getNotifications() async {
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: APIconst.notifications);

    if (response.success) {
      try {
        final List<NotificationModel> notifications = (response.data['data']['notifications'] as List)
            .map((e) => NotificationModel.fromJson(e as Map<String, dynamic>))
            .toList();
        emit(state.copyWith(state: RequestState.done, notifications: notifications));
      } catch (e) {
        emit(state.copyWith(state: RequestState.error, message: "خطأ في قراءة البيانات: $e"));
      }
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
    }
  }
}
