part of 'reset_password_cubit.dart';

@immutable
class ResetPasswordState {
  final RequestState state;
  final RequestState resetState;
  final String message;
  final ErrorType errorType;

  const ResetPasswordState({
    this.state = RequestState.initial,
    this.resetState = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
    // this.isPasswordObscure = true,
    // this.isConfirmPasswordObscure = true,
  });

  ResetPasswordState copyWith({
    RequestState? state,
    RequestState? resetState,
    String? message,
    ErrorType? errorType,
    // bool? isPasswordObscure,
    // bool? isConfirmPasswordObscure,
  }) {
    return ResetPasswordState(
      state: state ?? this.state,
      resetState: resetState ?? this.resetState,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
      // isPasswordObscure: isPasswordObscure ?? this.isPasswordObscure,
      // isConfirmPasswordObscure: isConfirmPasswordObscure ?? this.isConfirmPasswordObscure,
    );
  }
}
