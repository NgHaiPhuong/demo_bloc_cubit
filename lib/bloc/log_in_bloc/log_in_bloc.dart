import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dio/dio.dart';
import '../../model/user.dart';
import 'log_in_state.dart';

class LogInCubit extends Cubit<LogInState> {
  LogInCubit() : super(LogInInitial());

  Future<void> login(String email, String password) async {
    emit(LogInLoading());
    try {
      // Gọi GET để tìm user theo email
      final response = await DioClient.dio.get(
        'users',
        queryParameters: {"email": email},
      );

      if (response.statusCode == 200 &&
          response.data is List &&
          response.data.isNotEmpty) {
        final user = response.data[0];
        final List<UserModel> list = [];
        if (user['password'] == password) {
          emit(LogInSuccess("Đăng nhập thành công!", list));
        } else {
          emit(LogInError("Sai mật khẩu!"));
        }
      } else {
        emit(LogInError("Không tìm thấy tài khoản!"));
      }
    } catch (e) {
      emit(LogInError("Lỗi: ${e.toString()}"));
    }
  }

  void statusEye() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(errorText: ""));
    } else if (value.length < 6) {
      emit(state.copyWith(errorText: "Password at least 6 characters"));
    } else {
      emit(state.copyWith(errorText: ""));
    }
  }
}
