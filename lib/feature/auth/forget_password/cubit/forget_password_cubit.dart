import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';

part 'forget_password_state.dart';

class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  ForgetPasswordCubit() : super(const ForgetPasswordState());

  final formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();

  Future<void> forgetPassword(String phone) async {
    emit(state.copyWith(state: RequestState.loading));
    
    final response = await ServerGate.i.sendToServer(
      url: APIconst.forgetPassword,
      formData: {
        "phone": phone,
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

  @override
  Future<void> close() {
    phoneController.dispose();
    return super.close();
  }
}
