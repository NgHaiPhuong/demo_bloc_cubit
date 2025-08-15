import 'package:dome_ui2/features/data/models/user.dart';
import 'package:dome_ui2/features/domain/usecases/update_user.dart';
import 'package:dome_ui2/features/presentation/edit_user/bloc/edit_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/dio_client.dart';

class EditUserCubit extends Cubit<EditUserState> {
  final UpdateUser updateUserUseCase;

  EditUserCubit(this.updateUserUseCase) : super(EditUserInitial());

  Future<void> updateUser(String id, Map<String, dynamic> data) async {
    emit(EditUserLoading());
    try {
      final updatedUser = await updateUserUseCase(id, data);
      emit(EditUserSuccess("Cập nhật thành công", [updatedUser]));
    } catch (e) {
      emit(EditUserError(e.toString()));
    }
  }
}
