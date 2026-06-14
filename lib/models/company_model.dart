import 'base.dart';

class StoreModel extends Model {
  late final String name;
  late final String logo;
  late final String address;
  late final String phone;
  late final double avgRate;
  late bool isFav;

  StoreModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
    logo = stringFromJson(json?['logo'], "path");
    phone = stringFromJson(json, "phone");
    address = stringFromJson(json, "address");
    avgRate = doubleFromJson(json, "avg_rate", defaultValue: 0.0);
    isFav = boolFromJson(json, "is_fav", defaultValue: false);
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "phone": phone,
    "address": address,
    "avg_rate": avgRate,
    "is_fav": isFav,
  };
}
