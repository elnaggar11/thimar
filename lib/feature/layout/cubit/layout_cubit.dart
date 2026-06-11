import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/utils/enums.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutState());

  void changeIndex(int index) {
    if (index != state.selectedIndex) {
      emit(state.copyWith(selectedIndex: index));
    }
  }
}
