import 'base.dart';
import 'city_model.dart';
import 'district_model.dart';

/// Customer address returned by the API.
class AddressModel extends Model {
  late final String title;
  late final CityModel city;
  late final DistrictModel district;
  late final String addressName;
  late final String street;
  late final String location;
  late final double lat;
  late final double lng;
  late final bool isDefault;
  late final String buildingNumber;
  late final String details;

  String get name => [
    city.name,
    district.name,
    street,
    location,
  ].where((e) => e.isNotEmpty).join(", ");

  AddressModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    title = stringFromJson(json, "title");
    city = CityModel.fromJson(json?["city"] as Map<String, dynamic>?);
    district = DistrictModel.fromJson(
      json?["district"] as Map<String, dynamic>?,
    );
    street = stringFromJson(json, "street");
    location = stringFromJson(json, "location");
    lat = doubleFromJson(json, "lat");
    lng = doubleFromJson(json, "lng");
    isDefault = boolFromJson(json, "is_default");
    buildingNumber = stringFromJson(json, "property_number");
    details = stringFromJson(json, "details");
    addressName = stringFromJson(json, "name");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "city": city.toJson(),
    "district": district.toJson(),
    "street": street,
    "location": location,
    "lat": lat,
    "lng": lng,
    "is_default": isDefault,
    "property_number": buildingNumber,
    "details": details,
    "name": addressName,
  };
}
