import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/gen/locale_keys.g.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> {
  ResetPasswordCubit() : super(const ResetPasswordState());

  final formKey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  Future<void> resetPassword(String phone, String code) async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    if (passwordController.text != confirmPasswordController.text) {
      FlashHelper.showToast(
        LocaleKeys.validateMustMatchPassword.tr(),
        type: MessageType.fail,
      );
      return;
    }

    emit(state.copyWith(resetState: RequestState.loading));

    final response = await ServerGate.i.sendToServer(
      url: APIconst.resetPassword,
      formData: {
        "code": code,
        "phone": phone,
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text,
      },
    );

    if (response.success) {
      FlashHelper.showToast(response.msg, type: MessageType.success);
      emit(state.copyWith(resetState: RequestState.done));
    } else {
      FlashHelper.showToast(response.msg, type: MessageType.fail);
      emit(
        state.copyWith(resetState: RequestState.error, message: response.msg),
      );
    }
  }
}
