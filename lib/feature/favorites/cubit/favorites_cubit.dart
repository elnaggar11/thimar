import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/product_model.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesState()) {
    getFavorites();
  }

  Future<void> getFavorites() async {
    emit(state.copyWith(state: RequestState.loading));

    final response = await ServerGate.i.getFromServer(
      url: APIconst.getFavorites,
    );

    if (response.success) {
      final favorites = List<ProductModel>.from(
        (response.data['data'] ?? []).map((x) => ProductModel.fromJson(x)),
      );
      emit(state.copyWith(state: RequestState.done, favorites: favorites));
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
    }
  }

  Future<bool> toggleFavorite({required ProductModel product}) async {
    final bool isFavorite = product.isFavorite;

    if (!isFavorite) {
      // The product was un-favorited in the UI, so we remove it from server
      final response = await ServerGate.i.sendToServer(
        url: APIconst.removeFromFavorite(product.id),
      );

      if (response.success) {
        final newFavorites = List<ProductModel>.from(state.favorites);
        newFavorites.removeWhere((p) => p.id == product.id);
        emit(state.copyWith(favorites: newFavorites));
        return true;
      }
      return false;
    } else {
      // The product was favorited in the UI, so we add it to server
      final response = await ServerGate.i.sendToServer(
        url: APIconst.addToFavorite(product.id),
      );

      if (response.success) {
        // Refresh favorites list to get the updated list
        getFavorites();
        return true;
      }
      return false;
    }
  }
}
