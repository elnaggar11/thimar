part of 'faqs_cubit.dart';

class FaqsState {
  final RequestState state;
  final String message;
  final ErrorType errorType;
  final List<FaqModel> faqs;

  const FaqsState({
    this.state = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
    this.faqs = const [],
  });

  FaqsState copyWith({
    RequestState? state,
    String? message,
    ErrorType? errorType,
    List<FaqModel>? faqs,
  }) {
    return FaqsState(
      state: state ?? this.state,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
      faqs: faqs ?? this.faqs,
    );
  }
}
