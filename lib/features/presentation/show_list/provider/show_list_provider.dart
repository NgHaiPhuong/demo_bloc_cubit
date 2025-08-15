import 'package:dome_ui2/features/domain/usecases/show_list.dart';
import 'package:flutter/material.dart';

import '../../../data/models/user.dart' show UserModel;

class ShowListProvider extends ChangeNotifier {
  final ShowListUserCase showListUserCase;

  ShowListProvider(this.showListUserCase);

  bool isLoading = false;
  String? message;
  List<UserModel> users = [];

  Future<void> getListData() async {
    isLoading = true;
    notifyListeners();

    try {
      users = await showListUserCase();
      message = "Lấy danh sách thành công";
    } catch (e) {
      message = "Lỗi: ${e.toString()}";
    }

    isLoading = false;
    notifyListeners();
  }
}
