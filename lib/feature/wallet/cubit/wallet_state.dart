import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/models/wallet_model.dart';

class WalletState {
  final RequestState state;
  final String message;
  final WalletModel? walletData;

  WalletState({
    this.state = RequestState.initial,
    this.message = '',
    this.walletData,
  });

  WalletState copyWith({
    RequestState? state,
    String? message,
    WalletModel? walletData,
  }) {
    return WalletState(
      state: state ?? this.state,
      message: message ?? this.message,
      walletData: walletData ?? this.walletData,
    );
  }
}
