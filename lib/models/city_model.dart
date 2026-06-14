import 'base.dart';

/// Represents a city option returned by the API.
class CityModel extends Model {
  late final String name;

  late final double shippingFees;

  CityModel.fromJson([Map<String, dynamic>? json]) {
    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
    shippingFees = doubleFromJson(json, "shipping_fees");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "shipping_fees": shippingFees,
  };
}
