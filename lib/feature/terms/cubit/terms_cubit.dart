import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';

part 'terms_state.dart';

class TermsCubit extends Cubit<TermsState> {
  TermsCubit() : super(TermsState()) {
    getTerms();
  }

  Future<void> getTerms() async {
    emit(state.copyWith(state: RequestState.loading));
    final response = await ServerGate.i.getFromServer(url: APIconst.terms);
    if (response.success && response.data != null) {
      final String htmlData = response.data['data']['terms'] ?? '';
      emit(state.copyWith(state: RequestState.done, termsHtml: htmlData));
    } else {
      emit(state.copyWith(state: RequestState.error));
    }
  }
}
