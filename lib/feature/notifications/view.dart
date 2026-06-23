import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/core/widgets/loading.dart';
import 'package:thimar/core/widgets/main_app_bar.dart';
import 'package:thimar/feature/notifications/cubit/notifications_cubit.dart';
import 'package:thimar/feature/notifications/widgets/notification_item_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:thimar/gen/locale_keys.g.dart';

class NotificationsView extends StatefulWidget {
  const NotificationsView({super.key});

  @override
  State<NotificationsView> createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> {
  final _cubit = sl<NotificationsCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _cubit,
      child: Scaffold(
        appBar: MainAppBar(
          title: LocaleKeys.notifications.tr(),
          isTitleCentered: true,
          removeLeading: true,
        ),
        body: BlocBuilder<NotificationsCubit, NotificationsState>(
          builder: (context, state) {
            if (state.state == RequestState.loading) {
              return const Center(child: CustomProgress());
            }

            if (state.state == RequestState.error) {
              return Center(
                child: Text(
                  state.message,
                  style: context.boldText.copyWith(color: context.errorColor),
                ),
              );
            }

            if (state.notifications.isEmpty) {
              return Center(
                child: Text(
                  LocaleKeys.noNotifications.tr(),
                  style: context.regularText.copyWith(
                    color: context.hintColor,
                    fontSize: 16.sp,
                  ),
                ),
              );
            }

            return ListView.separated(
              padding: EdgeInsets.all(16.r),
              itemCount: state.notifications.length,
              separatorBuilder: (context, index) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                return NotificationItemWidget(
                  notification: state.notifications[index],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
