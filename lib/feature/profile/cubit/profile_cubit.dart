import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thimar/core/utils/enums.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState());
}
