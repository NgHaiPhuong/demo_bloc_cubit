import '../../data/models/user.dart';

class ShowListState {}

class ShowListInitial extends ShowListState {}

class ShowListLoading extends ShowListState {}

class ShowListSuccess extends ShowListState {
  final String message;
  final List<UserModel> users;

  ShowListSuccess(this.message, this.users);

  @override
  List<Object?> get props => [users];
}

class ShowListError extends ShowListState {
  final String error;

  ShowListError(this.error);
}
