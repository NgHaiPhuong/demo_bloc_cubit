
import 'package:dome_ui2/features/data/models/user.dart';
import 'package:dome_ui2/features/domain/usecases/sign_up.dart';
import 'package:flutter/cupertino.dart';

class SignUpProvider extends ChangeNotifier{
  final SignUpUserCase signUpUserCase;

  SignUpProvider(this.signUpUserCase);

  UserModel? user;
  String? errorText;
  String? errorEmail;
  bool obscureTextPass = true;
  bool obscureTextRePass = true;
  bool isSignUpSuccess = false;

  bool isLoading = false;
  String? message;

  Future<void> register(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      user = await signUpUserCase(email, password);
      message = "Đăng ký thành công";
    } catch (e) {
      message = "Lỗi: ${e.toString()}";
    }
    isLoading = false;
    notifyListeners();
  }

  void togglePasswordVisibility(bool isEnterPass) {
    if (isEnterPass) {
      obscureTextPass = !obscureTextPass;
    } else {
      obscureTextRePass = !obscureTextRePass;
    }
    notifyListeners();
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      errorEmail = null;
    } else if (!value.contains("@")) {
      errorEmail = "Please enter correct format";
    } else {
      errorEmail = null;
    }
    notifyListeners();
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      errorText = "";
    } else if (value.length < 6) {
      errorText = "Password at least 6 characters";
    } else {
      errorText = "";
    }
    notifyListeners();
  }

  void validateRePassword(String pass, String rePass) {
    if (pass == rePass) {
      errorText = "";
    } else {
      errorText = "Incorrect password";
    }
    notifyListeners();
  }
}
