import 'package:get_it/get_it.dart';
import 'package:thimar/core/services/location_service.dart';
import 'package:thimar/presentation/auth/forget_password/controller/cubit/forget_password_cubit.dart';
import 'package:thimar/presentation/auth/login/controller/cubit/login_cubit.dart';
import 'package:thimar/presentation/auth/sign_up/controller/cubit/sign_up_cubit.dart';
import 'package:thimar/presentation/splash/controller/splash_cubit/splash_cubit.dart';

final sl = GetIt.instance;

class ServicesLocator {
  void init() {
    sl.registerFactory(LocationService.new);
    sl.registerFactory(SplashCubit.new);
    sl.registerFactory(LoginCubit.new);
    sl.registerFactory(SignUpCubit.new);
    sl.registerFactory(ForgetPasswordCubit.new);
  }
}
