import 'package:dome_ui2/features/data/datasources/dio_client.dart';
import 'package:dome_ui2/features/data/models/user.dart';

class UserRemoteDataSource {

  Future<List<UserModel>> getUsers() async {
    final response = await DioClient.dio.get('users');

    if (response.statusCode == 200 && response.data is List) {
      return (response.data as List)
          .map((e) => UserModel.fromJson(e))
          .toList();
    } else {
      throw Exception("Lỗi dữ liệu");
    }
  }

  Future<UserModel> updateUser(String id, Map<String, dynamic> data) async {
    final response = await DioClient.dio.put('users/$id', data: data);

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception("Cập nhật thất bại");
    }
  }

  Future<UserModel> login(String email, String password) async {
    // Gọi GET để tìm user theo email
    final response = await DioClient.dio.get(
      'users',
      queryParameters: {"email": email},
    );

    if (response.statusCode == 200 &&
        response.data is List &&
        response.data.isNotEmpty) {
      final user = response.data[0];
      if (user['password'] == password) {
        return UserModel.fromJson(user);
      } else {
        throw Exception("Sai mật khẩu!");
      }
    } else {
      throw Exception("Không tìm thấy tài khoản!");
    }
  }

  Future<UserModel> register(String email, String password) async {
    final response = await DioClient.dio.post(
      'users', // endpoint của MockAPI
      data: {"email": email, "password": password},
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(response.data);
    } else {
      throw Exception("Đăng ký thất bại!");
    }
  }
}
