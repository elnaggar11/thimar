import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
part 'verify_state.dart';

class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit() : super(VerifyState());
  final formKey = GlobalKey<FormState>();
  final codeController = TextEditingController();

  Future<void> verify({
    required String phone,
    required VerifyType verifyType,
  }) async {
    emit(state.copyWith(state: RequestState.loading));

    String? url;
    if (verifyType == VerifyType.forgetPassword) {
      url = APIconst.passwordVerify;
    } else if (verifyType == VerifyType.register) {
      url = APIconst.verify;
    }
    final response = await ServerGate.i.sendToServer(
      url: url!,
      formData: {
        "code": codeController.text,
        "phone": phone,
        if (verifyType == VerifyType.register) ...{
          "device_token": "test",
          "type": "ios",
        },
      },
    );

    if (response.success) {
      FlashHelper.showToast(response.msg, type: MessageType.success);
      emit(state.copyWith(state: RequestState.done));
    } else {
      FlashHelper.showToast(response.msg, type: MessageType.fail);
      emit(state.copyWith(state: RequestState.error));
    }
  }

  Future<void> resend({required String phone}) async {
    final response = await ServerGate.i.sendToServer(
      url: APIconst.resend,
      formData: {"phone": phone},
    );

    if (response.success) {
      FlashHelper.showToast(response.msg, type: MessageType.success);
      emit(state.copyWith(state: RequestState.done));
    } else {
      FlashHelper.showToast(response.msg, type: MessageType.fail);
      emit(state.copyWith(state: RequestState.error));
    }
  }
}
