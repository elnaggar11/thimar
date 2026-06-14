import 'dart:convert';

import 'package:thimar/models/country_model.dart';

import '../main.dart';
import 'base.dart';

class UserModel extends Model {
  static final UserModel i = UserModel._();
  UserModel._();

  late String name, email, phone, userType, locale, token, phoneCode, birthday;
  late bool isActive, isNotify, canUseDeferredInvoice;
  late num balance;
  late String avatarPath;

  CountryModel? country;

  bool get isAuth => token.isNotEmpty;
  bool get isCompleteData => name.isNotEmpty;

  fromJson([Map<String, dynamic>? json]) {
    final data = json ?? {};
    id = stringFromJson(data, "id");
    name = stringFromJson(data, "name");
    phoneCode = stringFromJson(data, "phone_code");
    birthday = stringFromJson(data, "birthday");
    phone = stringFromJson(data, "phone");
    email = stringFromJson(data, "email");
    userType = stringFromJson(data, "user_type");
    locale = stringFromJson(data, "locale");
    isActive = boolFromJson(data, "is_active");
    isNotify = boolFromJson(data, "is_notify");
    canUseDeferredInvoice = boolFromJson(data, "can_use_deferred_invoice");
    balance = numFromJson(data, "balance");
    avatarPath = stringFromJson(data['avatar'], "path");
    token = stringFromJson(data, "token");
    country = data['country'] == null
        ? null
        : CountryModel.fromJson(data['country']);
  }

  save() {
    prefs.setString("user", jsonEncode(toJson()));
  }

  get() {
    fromJson(jsonDecode(prefs.getString("user") ?? "{}"));
  }

  clear() {
    prefs.remove("user");
    fromJson();
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "user_type": userType,
    "locale": locale,
    "is_active": isActive,
    "is_notify": isNotify,
    "can_use_deferred_invoice": canUseDeferredInvoice,
    "balance": balance,
    "avatar": {"path": avatarPath},
    "token": token,
    "phone_code": phoneCode,
    "birthday": birthday,
  };
}
