import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/feature/product_details/cubit/product_details_state.dart';
import 'package:thimar/models/product_model.dart';

import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/review_model.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsState());

  void init(ProductModel product) {
    emit(state.copyWith(product: product, quantity: 1));
    getProductDetails(product.id);
  }

  Future<void> getProductDetails(String productId) async {
    emit(state.copyWith(state: RequestState.loading));

    final response = await ServerGate.i.getFromServer(
      url: APIconst.productDetails(productId),
    );
    final ratesResponse = await ServerGate.i.getFromServer(
      url: APIconst.productRates(productId),
    );

    if (response.success) {
      final updatedProduct = ProductModel.fromJson(response.data['data']);

      List<ReviewModel> reviews = [];
      if (ratesResponse.success && ratesResponse.data['data'] != null) {
        reviews = List<ReviewModel>.from(
          (ratesResponse.data['data']).map((x) => ReviewModel.fromJson(x)),
        );
      }

      emit(
        state.copyWith(
          state: RequestState.done,
          product: updatedProduct,
          reviews: reviews,
        ),
      );
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
    }
  }

  void incrementQuantity() {
    emit(state.copyWith(quantity: state.quantity + 1));
  }

  void decrementQuantity() {
    if (state.quantity > 1) {
      emit(state.copyWith(quantity: state.quantity - 1));
    }
  }
}
