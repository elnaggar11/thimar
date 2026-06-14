import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/category_model.dart';
import 'package:thimar/models/product_model.dart';
import 'package:thimar/models/slider_model.dart';

class HomeState {
  final RequestState state;
  final String message;
  final List<CategoryModel> categories;
  final List<ProductModel> products;
  final List<SliderModel> banners;
  final int currentBannerIndex;

  HomeState({
    this.state = RequestState.initial,
    this.message = '',
    this.categories = const [],
    this.products = const [],
    this.banners = const [],
    this.currentBannerIndex = 0,
  });

  HomeState copyWith({
    RequestState? state,
    String? message,
    List<CategoryModel>? categories,
    List<ProductModel>? products,
    List<SliderModel>? banners,
    int? currentBannerIndex,
  }) {
    return HomeState(
      state: state ?? this.state,
      message: message ?? this.message,
      categories: categories ?? this.categories,
      products: products ?? this.products,
      banners: banners ?? this.banners,
      currentBannerIndex: currentBannerIndex ?? this.currentBannerIndex,
    );
  }
}
