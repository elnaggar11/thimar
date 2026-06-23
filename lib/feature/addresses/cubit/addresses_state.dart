import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/address_model.dart';

class AddressesState {
  final RequestState state;
  final String message;
  final List<AddressModel> addresses;

  AddressesState({
    this.state = RequestState.initial,
    this.message = '',
    this.addresses = const [],
  });

  AddressesState copyWith({
    RequestState? state,
    String? message,
    List<AddressModel>? addresses,
  }) {
    return AddressesState(
      state: state ?? this.state,
      message: message ?? this.message,
      addresses: addresses ?? this.addresses,
    );
  }
}
