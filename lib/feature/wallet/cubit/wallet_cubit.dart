import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/core/widgets/flash_helper.dart';
import 'package:thimar/models/wallet_model.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final amountController = TextEditingController();
  final nameController = TextEditingController();
  final cardController = TextEditingController();
  final expiryController = TextEditingController();
  final cvvController = TextEditingController();

  WalletCubit() : super(WalletState()) {
    getWalletData();
  }

  Future<void> getWalletData() async {
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: APIconst.wallet);

    if (response.success) {
      final WalletModel walletData = WalletModel.fromJson(
        response.data,
      );
      emit(state.copyWith(state: RequestState.done, walletData: walletData));
    } else {
      emit(state.copyWith(state: RequestState.error, message: response.msg));
    }
  }

  Future<bool> chargeWallet() async {
    if (amountController.text.isEmpty) return false;
    final amount = double.tryParse(amountController.text) ?? 0.0;
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.sendToServer(
      url: APIconst.chargeWallet,
      body: {
        'amount': amount,
        'transaction_id': "1111", // Dummy ID as per plan
      },
    );

    if (response.success) {
      FlashHelper.showToast(response.msg, type: MessageType.success);
      getWalletData();
      return true;
    } else {
      FlashHelper.showToast(response.msg, type: MessageType.fail);
      return false;
    }
  }

  @override
  Future<void> close() {
    amountController.dispose();
    nameController.dispose();
    cardController.dispose();
    expiryController.dispose();
    cvvController.dispose();
    return super.close();
  }
}
