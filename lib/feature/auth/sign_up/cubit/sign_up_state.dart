part of 'sign_up_cubit.dart';

class SignUpState {
  final RequestState state;
  final RequestState citiesState;
  final List<CityModel> cities;
  final CityModel? selectedCity;
  final String message;
  final ErrorType errorType;

  const SignUpState({
    this.state = RequestState.initial,
    this.citiesState = RequestState.initial,
    this.cities = const [],
    this.selectedCity,
    this.message = '',
    this.errorType = ErrorType.none,
  });

  SignUpState copyWith({
    RequestState? state,
    RequestState? citiesState,
    List<CityModel>? cities,
    CityModel? selectedCity,
    String? message,
    ErrorType? errorType,
  }) {
    return SignUpState(
      state: state ?? this.state,
      citiesState: citiesState ?? this.citiesState,
      cities: cities ?? this.cities,
      selectedCity: selectedCity ?? this.selectedCity,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
    );
  }
}
