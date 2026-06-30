import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/utils/enums.dart';

import 'rate_products_state.dart';

class RateProductsCubit extends Cubit<RateProductsState> {
  RateProductsCubit() : super(const RateProductsState());

  Future<void> submitRatings(List<Map<String, dynamic>> ratingsPayload) async {
    emit(state.copyWith(submitRatingState: RequestState.loading));

    // Placeholder endpoint, since user hasn't provided one yet
    // final response = await ServerGate.i.sendToServer(url: 'client/products/rate', formData: {'ratings': ratingsPayload});

    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    // Placeholder logic

    emit(state.copyWith(submitRatingState: RequestState.done));
  }
}
