import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/utils/enums.dart';

part 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit() : super(FavoritesState());
}
