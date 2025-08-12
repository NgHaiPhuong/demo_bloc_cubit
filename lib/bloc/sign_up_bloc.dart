import 'package:dome_ui2/dialog/dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../dio/dio.dart';
import '../model/User.dart';
import 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    emit(SignUpLoading());
    try {
      final response = await DioClient.dio.put(
        'users/$id',
        data: data,
      );

      if (response.statusCode == 200) {
        final updatedUser = UserModel.fromJson(response.data);
        emit(SignUpSuccess("Cập nhật thành công", [updatedUser]));
      } else {
        emit(SignUpError("Cập nhật thất bại"));
      }
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  Future<void> getListData() async {
    emit(SignUpLoading());
    try {
      final response = await DioClient.dio.get('users');

      if (response.statusCode == 200 && response.data is List) {
        final users = (response.data as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
        emit(SignUpSuccess("Thành công", users));
      } else {
        emit(SignUpError("Lỗi dữ liệu"));
      }
    } catch (e) {
      emit(SignUpError(e.toString()));
    }
  }

  Future<UserModel> getUserById(String id) async {
    try {
      final response = await DioClient.dio.get(
        'users',
        queryParameters: {"id": id},
      );

      if (response.statusCode == 200 &&
          response.data is List &&
          response.data.isNotEmpty) {
        return UserModel.fromJson(response.data[0]);
      }
      return UserModel(name: "", avatar: "", email: "", password: "", id: "");
    } catch (e) {
      throw Exception("Lỗi khi lấy user: $e");
    }
  }

  Future<void> login(String email, String password) async {
    emit(SignUpLoading());
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
          emit(SignUpSuccess("Đăng nhập thành công!", list));
        } else {
          emit(SignUpError("Sai mật khẩu!"));
        }
      } else {
        emit(SignUpError("Không tìm thấy tài khoản!"));
      }
    } catch (e) {
      emit(SignUpError("Lỗi: ${e.toString()}"));
    }
  }

  Future<void> register(String email, String password) async {
    emit(SignUpLoading());
    try {
      final response = await DioClient.dio.post(
        'users', // endpoint của MockAPI
        data: {"email": email, "password": password},
      );

      final List<UserModel> list = [];

      if (response.statusCode == 201) {
        emit(SignUpSuccess("Đăng ký thành công!", list));
      } else {
        emit(SignUpError("Đăng ký thất bại!"));
      }
    } catch (e) {
      emit(SignUpError("Lỗi: ${e.toString()}"));
    }
  }

  void changeData(String value) {
    if (value == "") {
      emit(state.copyWith(isHide: false));
    } else {
      emit(state.copyWith(isHide: true));
    }
  }

  void statusEye() {
    emit(state.copyWith(obscureText: !state.obscureText));
  }

  void togglePasswordVisibility(bool isEnterPass) {
    if (isEnterPass) {
      emit(state.copyWith(obscureTextPass: !state.obscureTextPass));
    } else {
      emit(state.copyWith(obscureTextRePass: !state.obscureTextRePass));
    }
  }

  void validateEmail(String value) {
    if (value.isEmpty) {
      emit(state.copyWith(errorEmail: null));
    } else if (!value.contains("@")) {
      emit(state.copyWith(errorEmail: "Please enter correct format"));
    } else {
      emit(state.copyWith(errorEmail: null));
    }
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

  void validateRePassword(String pass, String rePass) {
    if (pass == rePass) {
      emit(state.copyWith(errorText: ""));
    } else {
      emit(state.copyWith(errorText: "Incorrect password"));
    }
  }

  void signUp(BuildContext context, String email, String password) {
    if (state.errorEmail == null && (state.errorText == "")) {
      emit(state.copyWith(isSignUpSuccess: true));
      context.read<SignUpCubit>().register(email, password);

      ShowDialog().showLoginSuccessDialog(context);
    }
  }
}
