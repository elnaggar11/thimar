part of 'complaints_and_suggestions_cubit.dart';

class ComplaintsAndSuggestionsState {
  final RequestState state;
  final String msg;
  final ErrorType errorType;
  ComplaintsAndSuggestionsState({
    this.state = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
  });

  ComplaintsAndSuggestionsState copyWith({
    RequestState? state,
    String? msg,
    ErrorType? errorType,
  }) {
    return ComplaintsAndSuggestionsState(
      state: state ?? this.state,
      msg: msg ?? this.msg,
      errorType: errorType ?? this.errorType,
    );
  }
}
