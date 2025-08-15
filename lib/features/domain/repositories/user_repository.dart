import 'package:dome_ui2/features/data/models/user.dart';

abstract class UserRepository {
  Future<UserModel> updateUser(String id, Map<String, dynamic> data);
}