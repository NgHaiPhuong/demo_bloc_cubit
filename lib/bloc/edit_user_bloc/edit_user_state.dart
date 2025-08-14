import '../../data/models/user.dart';

class EditUserState {}

class EditUserInitial extends EditUserState {}

class EditUserLoading extends EditUserState {}

class EditUserSuccess extends EditUserState {
  final String message;
  final List<UserModel> users;

  EditUserSuccess(this.message, this.users);

  @override
  List<Object?> get props => [users];
}

class EditUserError extends EditUserState {
  final String error;

  EditUserError(this.error);
}
