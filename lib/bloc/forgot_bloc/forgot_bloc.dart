import 'package:flutter_bloc/flutter_bloc.dart';

import 'forgot_state.dart';

class ForgotCubit extends Cubit<ForgotState> {
  ForgotCubit() : super(ForgotInitial());

  void changeData(String value) {
    if (value == "") {
      emit(state.copyWith(isHide: false));
    } else {
      emit(state.copyWith(isHide: true));
    }
  }
}
