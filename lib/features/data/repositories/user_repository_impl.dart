import 'package:dome_ui2/features/data/datasources/user_data_sources.dart';
import 'package:dome_ui2/features/data/models/user.dart';

import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserModel> updateUser(String id, Map<String, dynamic> data) async {
    return await remoteDataSource.updateUser(id, data);
  }

  @override
  Future<UserModel> login(String email, String password) async {
    return await remoteDataSource.login(email, password);
  }

  @override
  Future<List<UserModel>> getListData() async {
    return await remoteDataSource.getUsers();
  }

  @override
  Future<UserModel> register(String email, String password) async {
    return await remoteDataSource.register(email, password);
  }
}
