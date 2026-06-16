import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/models/city_model.dart';
import 'package:thimar/models/user_model.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit() : super(PersonalInfoState()) {
    _initData();
  }

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();

  void _initData() {
    nameController.text = UserModel.i.name;
    phoneController.text = UserModel.i.phone.replaceFirst('966', '');
    cityController.text = UserModel.i.country?.name ?? '';
    getCities();
  }

  void setPickedImage(File file) {
    emit(state.copyWith(pickedImage: file));
  }

  void toggleEditMode() {
    if (state.isEditMode) {
      updateProfile();
    } else {
      emit(state.copyWith(isEditMode: true));
    }
  }

  Future<void> getCities() async {
    emit(state.copyWith(citiesState: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: 'cities/1');

    if (response.success &&
        response.data != null &&
        response.data!['data'] != null) {
      final List dataList = response.data!['data'] as List;
      final cities = dataList.map((e) => CityModel.fromJson(e)).toList();
      emit(state.copyWith(citiesState: RequestState.done, cities: cities));
    } else {
      emit(state.copyWith(citiesState: RequestState.error));
    }
  }

  void selectCity(CityModel city) {
    cityController.text = city.name;
    emit(state.copyWith(selectedCity: city));
  }

  Future<void> updateProfile() async {
    if (!formKey.currentState!.validate()) return;

    emit(state.copyWith(state: RequestState.loading));

    final Map<String, dynamic> body = {
      'fullname': nameController.text,
      'phone': phoneController.text,
      'city_id': state.selectedCity?.id,
      'image': state.pickedImage,
    };

    if (state.selectedCity != null) {
      body['city_id'] = state.selectedCity!.id;
    }

    if (state.pickedImage != null) {
      body['image'] = await MultipartFile.fromFile(state.pickedImage!.path);
    }

    final response = await ServerGate.i.sendToServer(
      url: APIconst.editProfile,
      formData: body,
    );

    if (response.success) {
      UserModel.i.fromJson(response.data!['data']);
      UserModel.i.save();

      emit(state.copyWith(state: RequestState.done, isEditMode: false));
      FlashHelper.showToast(response.msg, type: MessageType.success);
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
      FlashHelper.showToast(response.msg, type: MessageType.fail);
    }
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    cityController.dispose();
    return super.close();
  }
}
