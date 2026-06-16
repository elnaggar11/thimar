import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/models/user_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());

  Future<void> logout() async {
    emit(state.copyWith(logoutState: RequestState.loading));
    final response = await ServerGate.i.sendToServer(url: APIconst.logout);
    if (response.success &&
        response.data != null &&
        response.statusCode == 200) {
      await UserModel.i.clear();
      FlashHelper.showToast(response.msg, type: MessageType.success);
      emit(
        state.copyWith(logoutState: RequestState.done, message: response.msg),
      );
    } else {
      FlashHelper.showToast(response.msg, type: MessageType.fail);
      emit(
        state.copyWith(logoutState: RequestState.error, message: response.msg),
      );
    }
  }
}
