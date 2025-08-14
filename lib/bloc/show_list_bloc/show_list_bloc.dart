import 'package:dome_ui2/bloc/show_list_bloc/show_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dio/dio.dart';
import '../../data/models/user.dart';

class ShowListCubit extends Cubit<ShowListState> {
  ShowListCubit() : super(ShowListInitial());

  Future<void> getListData() async {
    emit(ShowListLoading());
    try {
      final response = await DioClient.dio.get('users');

      if (response.statusCode == 200 && response.data is List) {
        final users = (response.data as List)
            .map((e) => UserModel.fromJson(e))
            .toList();
        emit(ShowListSuccess("Thành công", users));
      } else {
        emit(ShowListError("Lỗi dữ liệu"));
      }
    } catch (e) {
      emit(ShowListError(e.toString()));
    }
  }
}
