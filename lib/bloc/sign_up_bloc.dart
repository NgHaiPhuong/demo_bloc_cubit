import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/home_page_tab_bar.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(const SignUpState());

  void changeData(String value) {
    if (value == "") {
      emit(state.copyWith(isHide: false));
    } else {
      emit(state.copyWith(isHide: true));
    }
  }

  void statusEye() {
    emit(state.copyWith(obscureText: !state.obscureText));
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

  void signUp(BuildContext context) {
    if (state.errorEmail == null && (state.errorText == "")) {
      emit(state.copyWith(isSignUpSuccess: true));
      showLoginSuccessDialog(context);
    }
  }

  void showLoginSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Thành công', textAlign: TextAlign.center),
          content: const Text(
            'Đăng nhập thành công!',
            textAlign: TextAlign.center,
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (context) => MyHomePage(currentTab: 0),
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
