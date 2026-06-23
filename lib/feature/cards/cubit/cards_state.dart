part of 'cards_cubit.dart';

class CardsState {
  final RequestState state;
  final RequestState addCardState;
  final String message;
  final ErrorType errorType;

  CardsState({
    this.state = RequestState.initial,
    this.addCardState = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
  });

  CardsState copyWith({
    RequestState? state,
    RequestState? addCardState,
    String? message,
    ErrorType? errorType,
  }) {
    return CardsState(
      state: state ?? this.state,
      addCardState: addCardState ?? this.addCardState,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
    );
  }
}
