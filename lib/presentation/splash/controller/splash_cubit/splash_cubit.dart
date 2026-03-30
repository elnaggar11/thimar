import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> navigateToNextScreen(BuildContext context) async {
    await Future.delayed(
      const Duration(seconds: 2),
      () => pushAndRemoveUntil(NamedRoutes.login),
    );
  }
}
