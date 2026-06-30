import 'package:thimar/core/utils/enums.dart';

class RateProductsState {
  final RequestState submitRatingState;
  final String message;

  const RateProductsState({
    this.submitRatingState = RequestState.initial,
    this.message = '',
  });

  RateProductsState copyWith({
    RequestState? submitRatingState,
    String? message,
  }) {
    return RateProductsState(
      submitRatingState: submitRatingState ?? this.submitRatingState,
      message: message ?? this.message,
    );
  }
}
