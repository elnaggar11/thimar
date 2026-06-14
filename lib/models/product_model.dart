import 'package:thimar/models/base.dart';

class ProductModel extends Model {
  late String name;
  late String description;
  late String logo;
  late String banner;
  late String brandName;
  late double rate;
  late double price;
  late double availableQuantity;
  late double priceAfterDiscount;
  late double discount;
  late bool isFavorite;

  ProductModel.fromJson(Map<String, dynamic> json) {
    final mainImage = json["main"] as Map<String, dynamic>?;
    final brand = json["brand"] as Map<String, dynamic>?;
    final logoValue = json["logo"];
    final bannerValue = json["banner"];

    id = stringFromJson(json, "id");
    name = stringFromJson(json, "name");
    description = stringFromJson(json, "description");
    logo = mainImage != null
        ? stringFromJson(mainImage, "path")
        : logoValue is Map<String, dynamic>
        ? stringFromJson(logoValue, "path")
        : (logoValue?.toString() ?? '');
    banner = mainImage != null
        ? stringFromJson(mainImage, "path")
        : bannerValue is Map<String, dynamic>
        ? stringFromJson(bannerValue, "path")
        : (bannerValue?.toString() ?? logo);
    brandName = stringFromJson(brand, "name");
    rate = doubleFromJson(json, "rate");
    price = doubleFromJson(json, "price");
    availableQuantity = doubleFromJson(json, "available_quantity");
    priceAfterDiscount = doubleFromJson(json, "price_after_discount");
    discount = doubleFromJson(json, "discount");
    isFavorite = boolFromJson(json, "is_favorite");
  }

  @override
  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "logo": logo,
    "banner": banner,
    "brand_name": brandName,
    "rate": rate,
    "price": price,
    "available_quantity": availableQuantity,
    "price_after_discount": priceAfterDiscount,
    "discount": discount,
    "is_favorite": isFavorite,
  };
}
