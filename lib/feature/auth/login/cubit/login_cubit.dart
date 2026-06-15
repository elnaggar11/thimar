import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginState());

  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  Future<void> login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(state: RequestState.loading));
    final resp = await ServerGate.i.sendToServer(
      url: APIconst.login,
      body: {
        "phone": phoneController.text,
        "password": passwordController.text,
        "device_token": "test",
        "type": "ios",
        "user_type": "client",
      },
    );
    if (resp.success) {
      FlashHelper.showToast(resp.msg, type: MessageType.success);
      emit(state.copyWith(state: RequestState.done));
    } else {
      FlashHelper.showToast(resp.msg, type: MessageType.fail);
      emit(state.copyWith(state: RequestState.error));
    }
  }
}
