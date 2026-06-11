part of 'layout_cubit.dart';

class LayoutState {
  final int selectedIndex;
  final RequestState state;
  final String message;
  final ErrorType errorType;

  LayoutState({
    this.selectedIndex = 0,
    this.state = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
  });

  LayoutState copyWith({
    int? selectedIndex,
    RequestState? state,
    String? message,
    ErrorType? errorType,
  }) {
    return LayoutState(
      selectedIndex: selectedIndex ?? this.selectedIndex,
      state: state ?? this.state,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
    );
  }
}
