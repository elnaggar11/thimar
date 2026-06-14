import 'base.dart';

class CountryModel extends Model {
  late final String name;
  late final String phoneCode;
  late final int phoneLimit;
  late final String flag;

  CountryModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
    phoneCode = stringFromJson(json, "phone_code");
    phoneLimit = intFromJson(json, "phone_limit");
    flag = stringFromJson(json?['flag'], "path");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone_code": phoneCode,
    "phone_limit": phoneLimit,
    "flag": flag,
  };
}
