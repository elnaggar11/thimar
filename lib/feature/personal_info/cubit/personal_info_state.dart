part of 'personal_info_cubit.dart';

class PersonalInfoState {
  final RequestState state;
  final String message;
  final ErrorType errorType;

  final bool isEditMode;

  final RequestState citiesState;
  final List<CityModel> cities;
  final CityModel? selectedCity;

  final File? pickedImage;

  PersonalInfoState({
    this.state = RequestState.initial,
    this.message = '',
    this.errorType = ErrorType.none,
    this.isEditMode = false,
    this.citiesState = RequestState.initial,
    this.cities = const [],
    this.selectedCity,
    this.pickedImage,
  });

  PersonalInfoState copyWith({
    RequestState? state,
    String? message,
    ErrorType? errorType,
    bool? isEditMode,
    RequestState? citiesState,
    List<CityModel>? cities,
    CityModel? selectedCity,
    File? pickedImage,
  }) {
    return PersonalInfoState(
      state: state ?? this.state,
      message: message ?? this.message,
      errorType: errorType ?? this.errorType,
      isEditMode: isEditMode ?? this.isEditMode,
      citiesState: citiesState ?? this.citiesState,
      cities: cities ?? this.cities,
      selectedCity: selectedCity ?? this.selectedCity,
      pickedImage: pickedImage ?? this.pickedImage,
    );
  }
}
