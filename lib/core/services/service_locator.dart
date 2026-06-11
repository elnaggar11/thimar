import 'package:get_it/get_it.dart';
import 'package:thimar/core/services/location_service.dart';
import 'package:thimar/feature/auth/forget_password/cubit/forget_password_cubit.dart';
import 'package:thimar/feature/auth/login/cubit/login_cubit.dart';
import 'package:thimar/feature/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:thimar/feature/layout/cubit/layout_cubit.dart';
import 'package:thimar/feature/splash/cubit/splash_cubit.dart';
import 'package:thimar/feature/orders/cubit/orders_cubit.dart';
import 'package:thimar/feature/favorites/cubit/favorites_cubit.dart';
import 'package:thimar/feature/profile/cubit/profile_cubit.dart';
import 'package:thimar/feature/notifications/cubit/notifications_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    sl.registerFactory(() => LocationService());
    sl.registerFactory(() => SplashCubit());
    sl.registerFactory(() => LoginCubit());
    sl.registerFactory(() => SignUpCubit());
    sl.registerFactory(() => ForgetPasswordCubit());
    sl.registerFactory(() => LayoutCubit());
    sl.registerFactory(() => OrdersCubit());
    sl.registerFactory(() => FavoritesCubit());
    sl.registerFactory(() => ProfileCubit());
    sl.registerFactory(() => NotificationsCubit());
  }
}
