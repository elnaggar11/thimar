import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/routes/app_routes_fun.dart';
import 'package:thimar/core/routes/routes.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/gen/locale_keys.g.dart';
import 'package:thimar/models/city_model.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final cityController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
      emit(
        state.copyWith(citiesState: RequestState.error, message: response.msg),
      );
    }
  }

  void selectCity(CityModel city) {
    cityController.text = city.name;
    emit(state.copyWith(selectedCity: city));
  }

  Future<void> signUp() async {
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
    if (state.selectedCity == null) {
      FlashHelper.showToast("يرجى اختيار المدينة", type: MessageType.fail);
      return;
    }
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.sendToServer(
      url: APIconst.register,
      body: {
        "fullname": usernameController.text,
        "password": passwordController.text,
        "phone": phoneController.text,
        "gender": "female",
        "password_confirmation": confirmPasswordController.text,
        "lat": "250.0515",
        "lng": "290.45",
      },
    );

    if (response.success) {
      FlashHelper.showToast(response.msg, type: MessageType.success);
      emit(state.copyWith(state: RequestState.done));
      push(NamedRoutes.verify, arg: {"phone": phoneController.text});
    } else {
      FlashHelper.showToast(response.msg, type: MessageType.fail);
      emit(state.copyWith(state: RequestState.error));
    }
  }

  @override
  Future<void> close() {
    usernameController.dispose();
    phoneController.dispose();
    cityController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
