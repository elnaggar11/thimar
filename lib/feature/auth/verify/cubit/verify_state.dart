part of 'verify_cubit.dart';

@immutable
class VerifyState {
  final RequestState state;
  final String? message;
  final ErrorType? error;

  const VerifyState({
    this.error,
    this.state = RequestState.initial,
    this.message,
  });

  VerifyState copyWith({
    RequestState? state,
    String? message,
    ErrorType? error,
  }) {
    return VerifyState(
      error: error,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }
}
