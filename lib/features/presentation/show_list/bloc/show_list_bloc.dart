import 'package:dome_ui2/features/data/models/user.dart';
import 'package:dome_ui2/features/presentation/show_list/bloc/show_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/datasources/dio_client.dart';

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
