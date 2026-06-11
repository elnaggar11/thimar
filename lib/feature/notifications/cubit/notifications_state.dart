part of 'notifications_cubit.dart';

class NotificationsState {
  final RequestState state;
  final String message;
  final ErrorType errorType;

  NotificationsState({
    this.state = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
  });

  NotificationsState copyWith({
    RequestState? state,
    String? message,
    ErrorType? errorType,
  }) {
    return NotificationsState(
      state: state ?? this.state,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
    );
  }
}
