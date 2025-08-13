import '../../model/user.dart';

class LogInState {
  final bool obscureText;
  final String errorText;

  const LogInState({this.obscureText = true, this.errorText = ""});

  LogInState copyWith({bool? obscureText, String? errorText}) {
    return LogInState(
      obscureText: obscureText ?? this.obscureText,
      errorText: errorText ?? this.errorText,
    );
  }
}

class LogInInitial extends LogInState {}

class LogInLoading extends LogInState {}

class LogInSuccess extends LogInState {
  final String message;
  final List<UserModel> users;

  LogInSuccess(this.message, this.users);

  @override
  List<Object?> get props => [users];
}

class LogInError extends LogInState {
  final String error;

  LogInError(this.error);
}
