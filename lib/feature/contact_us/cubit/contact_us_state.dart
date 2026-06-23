part of 'contact_us_cubit.dart';

class ContactUsState {
  final RequestState state;
  final RequestState sendState;
  final ContactInfoModel? contactInfo;

  ContactUsState({
    this.state = RequestState.initial,
    this.sendState = RequestState.initial,
    this.contactInfo,
  });

  ContactUsState copyWith({
    RequestState? state,
    RequestState? sendState,
    ContactInfoModel? contactInfo,
  }) {
    return ContactUsState(
      state: state ?? this.state,
      sendState: sendState ?? this.sendState,
      contactInfo: contactInfo ?? this.contactInfo,
    );
  }
}
