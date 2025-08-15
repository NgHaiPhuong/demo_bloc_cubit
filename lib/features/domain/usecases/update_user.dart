
import 'package:dome_ui2/features/data/models/user.dart';
import 'package:dome_ui2/features/domain/repositories/user_repository.dart';

class UpdateUser {
  final UserRepository repository;

  UpdateUser(this.repository);

  Future<UserModel> call(String id, Map<String, dynamic> data) async {
    return await repository.updateUser(id, data);
  }
}