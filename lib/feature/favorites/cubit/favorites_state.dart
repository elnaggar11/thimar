part of 'favorites_cubit.dart';

class FavoritesState {
  final RequestState state;
  final String message;
  final ErrorType errorType;

  FavoritesState({
    this.state = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
  });

  FavoritesState copyWith({
    RequestState? state,
    String? message,
    ErrorType? errorType,
  }) {
    return FavoritesState(
      state: state ?? this.state,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
    );
  }
}
