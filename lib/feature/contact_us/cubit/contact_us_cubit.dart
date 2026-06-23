import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/feature/contact_us/model/contact_info_model.dart';

part 'contact_us_state.dart';

class ContactUsCubit extends Cubit<ContactUsState> {
  ContactUsCubit() : super(ContactUsState()) {
    getContactInfo();
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final subjectController = TextEditingController();

  Future<void> getContactInfo() async {
    emit(state.copyWith(state: RequestState.loading));
    final resp = await ServerGate.i.getFromServer(url: APIconst.contact);
    if (resp.success && resp.data != null && resp.data['data'] != null) {
      final info = ContactInfoModel.fromJson(resp.data['data']);
      emit(state.copyWith(state: RequestState.done, contactInfo: info));
    } else {
      final info = ContactInfoModel(
        location: '119 شارع الملك فهد ، جدة ، المملكة العربية السعودية',
        phone: '+966 054 87452',
        email: 'info@thimar.com',
        lat: 21.5433,
        lng: 39.1728,
      );
      emit(state.copyWith(state: RequestState.done, contactInfo: info));
    }
  }

  Future<void> sendContact() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(sendState: RequestState.loading));

    final resp = await ServerGate.i.sendToServer(
      url: APIconst.contact,
      body: {
        "fullname": nameController.text,
        "phone": phoneController.text,
        "title": subjectController.text,
        "content": subjectController.text,
      },
    );

    if (resp.success) {
      FlashHelper.showToast(resp.msg, type: MessageType.success);
      emit(state.copyWith(sendState: RequestState.done));

      nameController.clear();
      phoneController.clear();
      subjectController.clear();
    } else {
      FlashHelper.showToast(resp.msg, type: MessageType.fail);
      emit(state.copyWith(sendState: RequestState.error));
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
