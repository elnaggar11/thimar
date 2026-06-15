part of 'forget_password_cubit.dart';

@immutable
class ForgetPasswordState {
  final RequestState state;
  final String? message;
  final ErrorType? error;

  const ForgetPasswordState({
    this.error,
    this.state = RequestState.initial,
    this.message,
  });

  ForgetPasswordState copyWith({
    RequestState? state,
    String? message,
    ErrorType? error,
  }) {
    return ForgetPasswordState(
      error: error ?? this.error,
      state: state ?? this.state,
      message: message ?? this.message,
    );
  }
}
