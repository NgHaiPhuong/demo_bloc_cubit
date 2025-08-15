import 'package:dome_ui2/features/domain/usecases/log_in.dart';
import 'package:dome_ui2/features/presentation/login/bloc/log_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogInCubit extends Cubit<LogInState> {
  final LogInUserCase logInUserCase;

  LogInCubit(this.logInUserCase) : super(LogInInitial());

  Future<void> login(String email, String password) async {
    emit(LogInLoading());
    try {
      final user = await logInUserCase(email, password);
      emit(LogInSuccess("Đăng nhập thành công", [user]));
    } catch (e) {
      emit(LogInError("Lỗi: ${e.toString()}"));
    }
  }

  void statusEye() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(errorText: ""));
    } else if (value.length < 6) {
      emit(state.copyWith(errorText: "Password at least 6 characters"));
    } else {
      emit(state.copyWith(errorText: ""));
    }
  }
}
