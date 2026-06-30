import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/category_model.dart';
import 'package:thimar/models/product_model.dart';
import 'package:thimar/models/slider_model.dart';

import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeState()) {
    getHomeData();
  }

  final searchController = TextEditingController();

  void getHomeData() async {
    emit(state.copyWith(state: RequestState.loading, clearSelectedCategoryId: true));

    final categoriesRes = await ServerGate.i.getFromServer(
      url: APIconst.categories,
    );
    final productsRes = await ServerGate.i.getFromServer(
      url: APIconst.products,
    );

    List<CategoryModel> categories = [];
    if (categoriesRes.success) {
      categories = List<CategoryModel>.from(
        (categoriesRes.data['data'] ?? []).map(
          (x) => CategoryModel.fromJson(x),
        ),
      );
    }

    List<ProductModel> products = [];
    if (productsRes.success) {
      products = List<ProductModel>.from(
        (productsRes.data['data'] ?? []).map((x) => ProductModel.fromJson(x)),
      );
    }

    final bool isSuccess = categoriesRes.success || productsRes.success;

    emit(
      state.copyWith(
        state: isSuccess ? RequestState.done : RequestState.error,
        message: isSuccess ? '' : categoriesRes.msg,
        categories: categories,
        products: products,
        clearSelectedCategoryId: true, // General products
      ),
    );
  }

  Future<void> getProductsByCategory(int categoryId) async {
    emit(
      state.copyWith(
        state: RequestState.loading,
        selectedCategoryId: categoryId,
      ),
    );

    final productsRes = await ServerGate.i.getFromServer(
      url: APIconst.categoryProducts(categoryId.toString()),
    );

    if (productsRes.success) {
      final products = List<ProductModel>.from(
        (productsRes.data['data'] ?? []).map((x) => ProductModel.fromJson(x)),
      );
      emit(state.copyWith(state: RequestState.done, products: products));
    } else {
      emit(state.copyWith(state: RequestState.error, message: productsRes.msg));
    }
  }

  Future<void> getSliders() async {
    emit(state.copyWith(state: RequestState.loading));

    final response = await ServerGate.i.getFromServer(url: APIconst.sliders);

    if (response.success) {
      final banners = List<SliderModel>.from(
        response.data['data'].map((x) => SliderModel.fromJson(x)),
      );
      emit(state.copyWith(state: RequestState.done, banners: banners));
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
    }
  }

  void changeBannerIndex(int index) {
    emit(state.copyWith(currentBannerIndex: index));
  }

  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
