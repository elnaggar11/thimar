import 'package:flutter/widgets.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/feature/about/view.dart';
import 'package:thimar/feature/auth/forget_password/view.dart';
import 'package:thimar/feature/auth/login/view.dart';
import 'package:thimar/feature/auth/verify/view.dart';
import 'package:thimar/feature/auth/reset_password/view.dart';
import 'package:thimar/feature/auth/sign_up/view.dart';
import 'package:thimar/feature/complaints_and_suggestions/view.dart';
import 'package:thimar/feature/layout/view.dart';
import 'package:thimar/feature/splash/view.dart';
import 'package:thimar/feature/product_details/view.dart';
import 'package:thimar/feature/faqs/view.dart';

import 'routes.dart';

class AppRoutes {
  static AppRoutes get init => AppRoutes._internal();
  String initial = NamedRoutes.splash;
  AppRoutes._internal();
  Map<String, Widget Function(BuildContext)> appRoutes = {
    NamedRoutes.splash: (c) => const SplashView(),
    NamedRoutes.login: (c) => const LoginView(),
    NamedRoutes.signUp: (c) => const SignUpView(),
    NamedRoutes.forgetPassword: (c) => const ForgetPasswordView(),
    NamedRoutes.verify: (c) => const VerifyView(),
    NamedRoutes.layout: (c) => const LayoutView(),
    NamedRoutes.resetPassword: (c) => const ResetPasswordView(),

    NamedRoutes.productDetails: (c) =>
        ProductDetailsView(product: c.arg['product']),
    NamedRoutes.faqs: (c) => const FaqsView(),
    NamedRoutes.complaintsAndSuggestions: (c) =>
        const ComplaintsAndSuggestionsView(),
    NamedRoutes.aboutUs: (c) => const AboutView(),
  };
}
