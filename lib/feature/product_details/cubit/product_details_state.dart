import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/product_model.dart';
import 'package:thimar/models/review_model.dart';

class ProductDetailsState {
  final RequestState state;
  final String message;
  final ProductModel? product;
  final List<ReviewModel> reviews;
  final int quantity;

  ProductDetailsState({
    this.state = RequestState.initial,
    this.message = '',
    this.product,
    this.reviews = const [],
    this.quantity = 1,
  });

  ProductDetailsState copyWith({
    RequestState? state,
    String? message,
    ProductModel? product,
    List<ReviewModel>? reviews,
    int? quantity,
  }) {
    return ProductDetailsState(
      state: state ?? this.state,
      message: message ?? this.message,
      product: product ?? this.product,
      reviews: reviews ?? this.reviews,
      quantity: quantity ?? this.quantity,
    );
  }
}
