import 'package:flutter/widgets.dart';

import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();
  String initial = NamedRoutes.createdSuccess;
  AppRoutes._internal();
  Map<String, Widget Function(BuildContext)> appRoutes = {
    // NamedRoutes.splash: (c) => const SplashScreen(),

    // NamedRoutes.bookingDetailsScreen: (c) => BookingDetailsScreen(
    //   bookingId: c.arg['id'],
    //   bookingDetails: c.arg['data'],
    // ),
  };
}
