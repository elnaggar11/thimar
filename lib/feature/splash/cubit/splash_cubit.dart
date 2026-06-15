import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/models/user_model.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> navigateToNextScreen(BuildContext context) async {
    if (UserModel.i.isAuth) {
      await Future.wait([Future.delayed(2.seconds)]);
      pushAndRemoveUntil(NamedRoutes.layout);
    } else {
      await Future.delayed(2.seconds);
      pushAndRemoveUntil(NamedRoutes.login);
    }
  }
}
