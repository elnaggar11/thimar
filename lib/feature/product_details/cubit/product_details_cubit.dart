import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/feature/product_details/cubit/product_details_state.dart';
import 'package:thimar/models/product_model.dart';

class ProductDetailsCubit extends Cubit<ProductDetailsState> {
  ProductDetailsCubit() : super(ProductDetailsState());

  void init(ProductModel product) {
    emit(state.copyWith(product: product, quantity: 1));
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
