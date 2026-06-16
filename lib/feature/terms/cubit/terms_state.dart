part of 'terms_cubit.dart';

class TermsState {
  final RequestState state;
  final String termsHtml;

  TermsState({
    this.state = RequestState.initial,
    this.termsHtml = '',
  });

  TermsState copyWith({
    RequestState? state,
    String? termsHtml,
  }) {
    return TermsState(
      state: state ?? this.state,
      termsHtml: termsHtml ?? this.termsHtml,
    );
  }
}
