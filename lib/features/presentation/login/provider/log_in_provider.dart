import 'package:dome_ui2/features/data/models/user.dart';
import 'package:dome_ui2/features/domain/usecases/log_in.dart';
import 'package:flutter/material.dart';

class LogInProvider extends ChangeNotifier {
  final LogInUserCase logInUserCase;

  LogInProvider(this.logInUserCase);

  bool obscureText = true;
  String? errorText;
  bool isLoading = false;
  String? message;
  List<UserModel> users = [];

  Future<void> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final user = await logInUserCase(email, password);
      message = "Đăng nhập thành công";
      users = [user];
    } catch (e) {
      message = "Lỗi: ${e.toString()}";
    }

    isLoading = false;
    notifyListeners();
  }

  void statusEye() {
    obscureText = !obscureText;
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
}
