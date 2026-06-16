import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';
import 'package:thimar/feature/faqs/model/faq_model.dart';

part 'faqs_state.dart';

class FaqsCubit extends Cubit<FaqsState> {
  FaqsCubit() : super(const FaqsState());

  Future<void> getFaqs() async {
    emit(state.copyWith(state: RequestState.loading));

    final response = await ServerGate.i.getFromServer(url: APIconst.faqs);

    if (response.success &&
        response.data != null &&
        response.data!['data'] != null) {
      final List dataList = response.data!['data'] as List;
      final faqs = dataList.map((e) => FaqModel.fromJson(e)).toList();

      if (faqs.isEmpty) {
        emit(state.copyWith(state: RequestState.empty));
      } else {
        emit(state.copyWith(state: RequestState.done, faqs: faqs));
      }
    }
  }
}
