import 'package:dome_ui2/features/data/datasources/dio_client.dart';
import 'package:dome_ui2/features/data/models/user.dart';

class UserRemoteDataSource {

  @override
  Future<UserModel> updateUser(String id, Map<String, dynamic> data) async {
    final response = await DioClient.dio.put('users/$id', data: data);

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception("Cập nhật thất bại");
    }
  }
}
