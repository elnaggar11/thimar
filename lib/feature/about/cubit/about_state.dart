part of 'about_cubit.dart';

class AboutState {
  final RequestState state;
  final String msg;
  final ErrorType errorType;
  final String about;
  AboutState({
    this.state = RequestState.initial,
    this.msg = '',
    this.errorType = ErrorType.none,
    this.about = '',
  });

  AboutState copyWith({
    RequestState? state,
    String? msg,
    ErrorType? errorType,
    String? about,
  }) {
    return AboutState(
      state: state ?? this.state,
      msg: msg ?? this.msg,
      errorType: errorType ?? this.errorType,
      about: about ?? this.about,
    );
  }
}
