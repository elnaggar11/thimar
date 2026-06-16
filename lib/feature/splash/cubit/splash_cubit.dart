import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/extensions.dart';
import 'package:thimar/models/user_model.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial());

  Future<void> navigateToNextScreen(BuildContext context) async {
    if (UserModel.i.isAuth) {
      await Future.wait([Future.delayed(2.seconds), _fetchProfile()]);
      pushAndRemoveUntil(NamedRoutes.layout);
    } else {
      await Future.delayed(2.seconds);
      pushAndRemoveUntil(NamedRoutes.login);
    }
  }

  Future<void> _fetchProfile() async {
    try {
      final resp = await ServerGate.i.getFromServer(url: APIconst.profile);
      if (resp.success) {
        final oldToken = UserModel.i.token;
        UserModel.i.fromJson(resp.data['data']);
        UserModel.i.token = oldToken;
        UserModel.i.save();
      }
    } catch (e) {
      // Safe fallback: proceed offline if API call fails
    }
  }
}
