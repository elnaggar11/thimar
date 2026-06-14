import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/product_model.dart';

class ProductDetailsState {
  final RequestState state;
  final String message;
  final ErrorType errorType;
  final ProductModel? product;
  final int quantity;

  ProductDetailsState({
    this.state = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
    this.product,
    this.quantity = 1,
  });

  ProductDetailsState copyWith({
    RequestState? state,
    String? message,
    ErrorType? errorType,
    ProductModel? product,
    int? quantity,
  }) {
    return ProductDetailsState(
      state: state ?? this.state,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
    );
  }
}
