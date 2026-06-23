import 'base.dart';

/// Customer address returned by the API.
class AddressModel extends Model {
  late final String type;
  late final double lat;
  late final double lng;
  late final String location;
  late final String description;
  late final bool isDefault;
  late final String phone;

  AddressModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    type = stringFromJson(json, "type");
    lat = doubleFromJson(json, "lat");
    lng = doubleFromJson(json, "lng");
    location = stringFromJson(json, "location");
    description = stringFromJson(json, "description");
    isDefault = boolFromJson(json, "is_default");
    phone = stringFromJson(json, "phone");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "lat": lat,
    "lng": lng,
    "location": location,
    "description": description,
    "is_default": isDefault,
    "phone": phone,
  };
}
