part of 'profile_cubit.dart';

class ProfileState {
  final RequestState logoutState;
  final String message;
  final ErrorType errorType;

  ProfileState({
    this.logoutState = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
  });

  ProfileState copyWith({
    RequestState? logoutState,
    String? message,
    ErrorType? errorType,
  }) {
    return ProfileState(
      logoutState: logoutState ?? this.logoutState,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
    );
  }
}
