import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';

part 'policy_state.dart';

class PolicyCubit extends Cubit<PolicyState> {
  PolicyCubit() : super(PolicyState()) {
    getPolicy();
  }

  Future<void> getPolicy() async {
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: APIconst.policy);
    if (response.success && response.data != null) {
      final String htmlData = response.data['data']['policy'] ?? '';
      emit(state.copyWith(state: RequestState.done, policyHtml: htmlData));
    } else {
      emit(state.copyWith(state: RequestState.error));
    }
  }
}
