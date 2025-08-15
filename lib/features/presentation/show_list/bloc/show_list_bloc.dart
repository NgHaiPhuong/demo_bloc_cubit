import 'package:dome_ui2/features/domain/usecases/show_list.dart';
import 'package:dome_ui2/features/presentation/show_list/bloc/show_list_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowListCubit extends Cubit<ShowListState> {
  final ShowListUserCase showListUserCase;

  ShowListCubit(this.showListUserCase) : super(ShowListInitial());

  Future<void> getListData() async {
    emit(ShowListLoading());
    try {
      final list = await showListUserCase();
      emit(ShowListSuccess("Lấy danh sách thành công", list));
    } catch (e) {
      emit(ShowListError(e.toString()));
    }
  }
}
