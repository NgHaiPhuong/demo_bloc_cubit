import 'package:dome_ui2/core/utils/dialog.dart';
import 'package:dome_ui2/features/data/models/user.dart';
import 'package:dome_ui2/features/domain/usecases/sign_up.dart';
import 'package:dome_ui2/features/presentation/signup/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUserCase signUpUserCase;

  SignUpCubit(this.signUpUserCase) : super(SignUpInitial());

  Future<void> register(String email, String password) async {
    emit(SignUpLoading());
    try {
      final user = await signUpUserCase.call(email, password);
      final List<UserModel> list = [];
      list.add(user);
      emit(SignUpSuccess("Đăng ký thành công!", list));
    } catch (e) {
      emit(SignUpError("Lỗi: ${e.toString()}"));
    }
  }

  void togglePasswordVisibility(bool isEnterPass) {
    if (isEnterPass) {
      emit(state.copyWith(obscureTextPass: !state.obscureTextPass));
    } else {
      emit(state.copyWith(obscureTextRePass: !state.obscureTextRePass));
    }
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(errorEmail: null));
    } else if (!value.contains("@")) {
      emit(state.copyWith(errorEmail: "Please enter correct format"));
    } else {
      emit(state.copyWith(errorEmail: null));
    }
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

  void validateRePassword(String pass, String rePass) {
    if (pass == rePass) {
      emit(state.copyWith(errorText: ""));
    } else {
      emit(state.copyWith(errorText: "Incorrect password"));
    }
  }

  void signUp(BuildContext context, String email, String password) {
    if (state.errorEmail == null && (state.errorText == "")) {
      emit(state.copyWith(isSignUpSuccess: true));
      context.read<SignUpCubit>().register(email, password);

      ShowDialog().showLoginSuccessDialog(context, "Đăng nhập thành công");
    }
  }
}
