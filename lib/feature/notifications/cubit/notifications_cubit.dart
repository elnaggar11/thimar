import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/utils/enums.dart';

part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit() : super(NotificationsState());
}
