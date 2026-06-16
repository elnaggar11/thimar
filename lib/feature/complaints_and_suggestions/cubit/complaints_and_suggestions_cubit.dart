import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';

part 'complaints_and_suggestions_state.dart';

class ComplaintsAndSuggestionsCubit
    extends Cubit<ComplaintsAndSuggestionsState> {
  ComplaintsAndSuggestionsCubit() : super(ComplaintsAndSuggestionsState());

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();

  Future<void> sendContact() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(state: RequestState.loading));

    final resp = await ServerGate.i.sendToServer(
      url: APIconst.contact,
      body: {
        "fullname": nameController.text,
        "phone": phoneController.text,
        "content": subjectController.text,
      },
    );

    if (resp.success) {
      FlashHelper.showToast(resp.msg, type: MessageType.success);
      emit(state.copyWith(state: RequestState.done));

      // Clear fields after success
      nameController.clear();
      phoneController.clear();
      subjectController.clear();
    } else {
      FlashHelper.showToast(resp.msg, type: MessageType.fail);
      emit(state.copyWith(state: RequestState.error));
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    subjectController.dispose();
    return super.close();
  }
}
