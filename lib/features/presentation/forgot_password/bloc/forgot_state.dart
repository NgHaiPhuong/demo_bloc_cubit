import 'package:dome_ui2/features/data/models/user.dart';

class ForgotState {
  final bool isHide;

  const ForgotState({this.isHide = false});

  ForgotState copyWith({bool? isHide}) {
    return ForgotState(isHide: isHide ?? this.isHide);
  }
}

class ForgotInitial extends ForgotState {}

class ForgotLoading extends ForgotState {}

class ForgotSuccess extends ForgotState {
  final String message;
  final List<UserModel> users;

  ForgotSuccess(this.message, this.users);

  @override
  List<Object?> get props => [users];
}

class ForgotError extends ForgotState {
  final String error;

  ForgotError(this.error);
}
