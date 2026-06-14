import 'package:thimar/models/categories_model.dart';
import 'package:thimar/models/product_model.dart';
import 'package:thimar/models/slider_model.dart';

import 'base.dart';
import 'most_rated_vendor_model.dart';

class HomeModel extends Model {
  late final List<SliderModel> sliders;
  late final List<MostRatedVendorModel> mostRatedVendor;
  late final List<ProductModel> bestSellerProducts;
  late final List<ProductModel> mostRatedProducts;
  late final List<ProductModel> recommendedProducts;
  late final List<CategoriesModel> categories;

  HomeModel.fromJson([Map<String, dynamic>? json]) {
    sliders = listFromJson<SliderModel>(
      json,
      "sliders",
      callback: (e) => SliderModel.fromJson(e),
    );
    mostRatedVendor = listFromJson<MostRatedVendorModel>(
      json,
      "most_rated_vendor",
      callback: (e) => MostRatedVendorModel.fromJson(e),
    );
    bestSellerProducts = listFromJson<ProductModel>(
      json,
      "best_seller",
      callback: (e) => ProductModel.fromJson(e),
    );
    mostRatedProducts = listFromJson<ProductModel>(
      json,
      "most_rated_product",
      callback: (e) => ProductModel.fromJson(e),
    );
    recommendedProducts = listFromJson<ProductModel>(
      json,
      "recommended",
      callback: (e) => ProductModel.fromJson(e),
    );
    categories = listFromJson<CategoriesModel>(
      json,
      "categories",
      callback: (e) => CategoriesModel.fromJson(e),
    );
  }

  @override
  Map<String, dynamic> toJson() => {
    "sliders": sliders.map((slider) => slider.toJson()).toList(),
    "most_rated_vendor": mostRatedVendor
        .map((category) => category.toJson())
        .toList(),
    "best_seller": bestSellerProducts
        .map((category) => category.toJson())
        .toList(),
    "most_rated_product": mostRatedProducts
        .map((category) => category.toJson())
        .toList(),
    "recommended": recommendedProducts
        .map((category) => category.toJson())
        .toList(),
    "categories": categories.map((category) => category.toJson()).toList(),
  };
}
