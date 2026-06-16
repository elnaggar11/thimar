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
    emit(state.copyWith(state: RequestState.loading));

    await Future.delayed(const Duration(milliseconds: 500));

    // Dummy Categories
    final categories = [
      CategoryModel.fromJson({
        "id": 1,
        "name": 'vegetables', // Will be translated in UI
        "image": {"path": 'assets/icons/vegetable.svg'},
      }),
      CategoryModel.fromJson({
        "id": 2,
        "name": 'fruits',
        "image": {
          "path": 'assets/icons/vegetable.svg',
        }, // using available dummy icon
      }),
      CategoryModel.fromJson({
        "id": 3,
        "name": 'meat',
        "image": {
          "path": 'assets/icons/item.svg',
        }, // using available dummy icon
      }),
      CategoryModel.fromJson({
        "id": 4,
        "name": 'spices',
        "image": {
          "path": 'assets/icons/setting.svg',
        }, // using available dummy icon
      }),
    ];

    // Dummy Products
    final products = List.generate(
      4,
      (index) => ProductModel.fromJson({
        "id": index,
        "name": 'طماطم', // Tomato
        "main": {
          "path":
              'https://img.freepik.com/free-photo/tomatoes_144627-15411.jpg',
        },
        "price": 56.0,
        "discount": 45.0,
        "price_after_discount": 45.0,
      }),
    );

    emit(
      state.copyWith(
        state: RequestState.done,
        categories: categories,
        products: products,
      ),
    );
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
