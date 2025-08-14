import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dio/dio.dart';
import '../../data/models/user.dart';
import 'edit_user_state.dart';

class EditUserCubit extends Cubit<EditUserState> {
  EditUserCubit() : super(EditUserInitial());

  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    emit(EditUserLoading());
    try {
      final response = await DioClient.dio.put('users/$id', data: data);

      if (response.statusCode == 200) {
        final updatedUser = UserModel.fromJson(response.data);
        emit(EditUserSuccess("Cập nhật thành công", [updatedUser]));
      } else {
        emit(EditUserError("Cập nhật thất bại"));
      }
    } catch (e) {
      emit(EditUserError(e.toString()));
    }
  }
}
