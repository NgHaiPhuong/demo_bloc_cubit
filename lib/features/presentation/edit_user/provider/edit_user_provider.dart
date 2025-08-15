import 'package:dome_ui2/features/data/models/user.dart';
import 'package:dome_ui2/features/domain/usecases/update_user.dart';
import 'package:flutter/widgets.dart';

class EditUserProvider extends ChangeNotifier {
  final UpdateUser updateUserUseCase;

  EditUserProvider(this.updateUserUseCase);

  bool isLoading = false;
  String? message;
  UserModel? user;

  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    isLoading = true;
    notifyListeners();

    try {
      user = await updateUserUseCase(id, data);
      message = "Cập nhật thành công";
    } catch (e) {
      message = "Lỗi: ${e.toString()}";
    }

    isLoading = false;
    notifyListeners();
  }
}
