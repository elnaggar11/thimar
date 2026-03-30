import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/presentation/auth/forget_password/controller/cubit/forget_password_cubit.dart';
import 'package:thimar/presentation/auth/forget_password/view/forget_password_view.dart';
import 'package:thimar/presentation/auth/login/controller/cubit/login_cubit.dart';
import 'package:thimar/presentation/auth/login/view/login_view.dart';
import 'package:thimar/presentation/auth/sign_up/controller/cubit/sign_up_cubit.dart';
import 'package:thimar/presentation/auth/sign_up/view/sign_up_view.dart';
import 'package:thimar/presentation/splash/controller/splash_cubit/splash_cubit.dart';
import 'package:thimar/presentation/splash/view/splash_view.dart';

import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();
  String initial = NamedRoutes.splash;
  AppRoutes._internal();
  Map<String, Widget Function(BuildContext)> appRoutes = {
    NamedRoutes.splash: (c) => BlocProvider(
      create: (context) => sl<SplashCubit>(),
      child: const SplashView(),
    ),
    NamedRoutes.login: (c) => BlocProvider(
      create: (context) => sl<LoginCubit>(),
      child: const LoginView(),
    ),
    NamedRoutes.signUp: (c) => BlocProvider(
      create: (context) => sl<SignUpCubit>(),
      child: const SignUpView(),
    ),
    NamedRoutes.forgetPassword: (c) => BlocProvider(
      create: (context) => sl<ForgetPasswordCubit>(),
      child: const ForgetPasswordView(),
    ),
    // NamedRoutes.bookingDetailsScreen: (c) => BookingDetailsScreen(
    //   bookingId: c.arg['id'],
    //   bookingDetails: c.arg['data'],
    // ),
  };
}
