import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/services/server_gate.dart';
import 'package:thimar/core/utils/app_constant.dart';
import 'package:thimar/core/utils/enums.dart';

part 'about_state.dart';

class AboutCubit extends Cubit<AboutState> {
  AboutCubit() : super(AboutState());

  Future<void> getAbout() async {
    emit(state.copyWith(state: RequestState.loading));

    final resp = await ServerGate.i.getFromServer(url: APIconst.about);

    if (resp.success) {
      emit(
        state.copyWith(
          state: RequestState.done,
          about: resp.data['data']['about'],
        ),
      );
    } else {
      emit(state.copyWith(state: RequestState.error));
    }
  }
}
