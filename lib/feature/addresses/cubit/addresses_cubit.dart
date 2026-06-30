import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/models/address_model.dart';
import 'addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  final phoneController = TextEditingController();
  final descController = TextEditingController();

  AddressesCubit() : super(AddressesState()) {
    getAddresses();
  }

  Future<void> getAddresses() async {
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: APIconst.addresses);

    if (response.success) {
      final data = response.data['data'];
      final List<AddressModel> addresses = data != null
          ? (data as List).map((e) => AddressModel.fromJson(e)).toList()
          : [];
      emit(state.copyWith(state: RequestState.done, addresses: addresses));
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
    }
  }

  Future<bool> addAddress({
    required String type,
    required String phone,
    required String description,
    required double lat,
    required double lng,
  }) async {
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.sendToServer(
      url: APIconst.addresses,
      formData: {
        'type': type,
        'phone': phone,
        'description': description,
        'location': 'موقع محدد من الخريطة',
        'lat': lat.toString(),
        'lng': lng.toString(),
        'is_default': '1',
      },
    );

    if (response.success) {
      FlashHelper.showToast(response.msg, type: MessageType.success);
      getAddresses();
      return true;
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
      FlashHelper.showToast(response.msg, type: MessageType.fail);
      return false;
    }
  }

  Future<bool> updateAddress({
    required String id,
    required String type,
    required String phone,
    required String description,
    required double lat,
    required double lng,
  }) async {
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.putToServer(
      url: APIconst.updateAddress(id),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'type': type,
        'phone': phone,
        'description': description,
        'location': 'موقع محدد من الخريطة',
        'lat': lat,
        'lng': lng,
        'is_default': 1,
      },
    );

    if (response.success) {
      FlashHelper.showToast(response.msg, type: MessageType.success);
      getAddresses();
      return true;
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
      FlashHelper.showToast(response.msg, type: MessageType.fail);
      return false;
    }
  }

  Future<bool> deleteAddress(String id, {String? type}) async {
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.deleteFromServer(
      url: APIconst.deleteAddress(id),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        if (type != null) 'type': type,
      },
    );

    if (response.success) {
      FlashHelper.showToast(response.msg, type: MessageType.success);
      getAddresses();
      return true;
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
      FlashHelper.showToast(response.msg, type: MessageType.fail);
      return false;
    }
  }

  @override
  Future<void> close() {
    phoneController.dispose();
    descController.dispose();
    return super.close();
  }
}
