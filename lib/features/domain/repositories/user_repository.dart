import 'package:dome_ui2/features/data/models/user.dart';

abstract class UserRepository {
  Future<UserModel> updateUser(String id, Map<String, dynamic> data);

  Future<UserModel> login(String email, String password);

  Future<List<UserModel>> getListData();

  Future<UserModel> register(String email, String password);
}
