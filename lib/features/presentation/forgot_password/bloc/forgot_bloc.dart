import 'package:dome_ui2/features/presentation/forgot_password/bloc/forgot_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
