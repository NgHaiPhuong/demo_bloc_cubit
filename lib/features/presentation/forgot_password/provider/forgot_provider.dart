import 'package:flutter/material.dart';

class ForgotProvider extends ChangeNotifier {
  bool isHide = false;

  void changeData(String value) {
    if (value.isEmpty) {
      isHide = false;
    } else {
      isHide = true;
    }
    notifyListeners();
  }
}