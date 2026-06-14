import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/service_locator.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/feature/auth/forget_password/view.dart';
import 'package:thimar/feature/auth/login/cubit/login_cubit.dart';
import 'package:thimar/feature/auth/login/view.dart';
import 'package:thimar/feature/auth/verify/view.dart';
import 'package:thimar/feature/auth/sign_up/cubit/sign_up_cubit.dart';
import 'package:thimar/feature/auth/sign_up/view.dart';
import 'package:thimar/feature/layout/view.dart';
import 'package:thimar/feature/splash/cubit/splash_cubit.dart';
import 'package:thimar/feature/splash/view.dart';
import 'package:thimar/feature/product_details/view.dart';

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
    NamedRoutes.forgetPassword: (c) => const ForgetPasswordView(),
    NamedRoutes.verify: (c) => const VerifyView(),
    NamedRoutes.layout: (c) => const LayoutView(),
    // NamedRoutes.resetPassword: (c) => BlocProvider(
    //   create: (context) => sl<ResetPasswordCubit>(),
    //   child: const ResetPasswordView(),
    // ),
    // NamedRoutes.bookingDetailsScreen: (c) => BookingDetailsScreen(
    //   bookingId: c.arg['id'],
    //   bookingDetails: c.arg['data'],
    // ),
    NamedRoutes.productDetails: (c) =>
        ProductDetailsView(product: c.arg['product']),
  };
}
