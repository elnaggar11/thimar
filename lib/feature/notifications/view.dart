import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/feature/notifications/cubit/notifications_cubit.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<NotificationsCubit>(),
      child: const Scaffold(
        body: Center(
          child: Text("Notifications View"),
        ),
      ),
    );
  }
}
