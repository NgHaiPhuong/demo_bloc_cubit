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
}
