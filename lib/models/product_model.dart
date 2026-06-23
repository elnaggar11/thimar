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
    id = stringFromJson(json, "id");
    name = stringFromJson(json, "title");
    if (name.isEmpty) {
      name = stringFromJson(json, "name"); // Fallback
    }
    description = stringFromJson(json, "description");
    
    // API returns main_image as string
    logo = stringFromJson(json, "main_image");
    banner = stringFromJson(json, "main_image");
    
    // In case the API still uses the old format somewhere, we can keep fallbacks
    if (logo.isEmpty) {
      final mainImageObj = json["main"] as Map<String, dynamic>?;
      if (mainImageObj != null) {
        logo = stringFromJson(mainImageObj, "path");
        banner = logo;
      }
    }

    brandName = ""; // Not in this API
    rate = doubleFromJson(json, "rate");
    
    // price_before_discount in API is the original price
    price = doubleFromJson(json, "price_before_discount");
    if (price == 0) price = doubleFromJson(json, "price"); // Fallback
    
    // price in API is the price AFTER discount
    priceAfterDiscount = doubleFromJson(json, "price");
    
    availableQuantity = doubleFromJson(json, "amount");
    discount = doubleFromJson(json, "discount");
    if (discount > 0 && discount <= 1) {
      discount = discount * 100;
    }
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
