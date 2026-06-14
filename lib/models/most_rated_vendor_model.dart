import 'package:thimar/models/base.dart';

class MostRatedVendorModel extends Model {
  late String name;
  late String description;
  late String logo;
  late String banner;
  late double rate;
  late String location;
  late String city;
  late String locationDetails;
  late bool isFavorite;

  // "location": {
  //     "id": 1,
  //     "lat": 24.620599999999999596411726088263094425201416015625,
  //     "lng": 46.6323000000000007503331289626657962799072265625,
  //     "name": "Store Location 1",
  //     "property_number": "Building 9",
  //     "details": "Main store location for Vendor 1",
  //     "is_default": true,
  //     "city": {
  //         "id": 1,
  //         "name": "Riyadh"
  //     }
  // }
  MostRatedVendorModel.fromJson(Map<String, dynamic>? json) {
    final locationJson = json?["location"] as Map<String, dynamic>?;
    final cityJson = locationJson?["city"] as Map<String, dynamic>?;

    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
    description = stringFromJson(json, "description");
    logo = stringFromJson(json?["logo"], "path");
    banner = stringFromJson(json?["banner"], "path");
    rate = doubleFromJson(json, "rate");
    location = stringFromJson(locationJson, "name");
    locationDetails = stringFromJson(locationJson, "details");
    city = stringFromJson(cityJson, "name");
    isFavorite = boolFromJson(json, "is_favorite");
  }

  @override
  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "logo": logo,
    "banner": banner,
    "rate": rate,
    "location": location,
    "city": city,
    "details": locationDetails,
    "is_favorite": isFavorite,
  };
}
