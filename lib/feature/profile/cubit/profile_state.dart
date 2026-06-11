part of 'profile_cubit.dart';

class ProfileState {
  final RequestState state;
  final String message;
  final ErrorType errorType;

  ProfileState({
    this.state = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
  });

  ProfileState copyWith({
    RequestState? state,
    String? message,
    ErrorType? errorType,
  }) {
    return ProfileState(
      state: state ?? this.state,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
    );
  }
}
