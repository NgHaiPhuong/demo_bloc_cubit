class SignUpState {
  final bool obscureTextPass;
  final bool obscureTextRePass;
  final bool obscureText;
  final String? errorEmail;
  final String errorText;
  final bool isSignUpSuccess;
  final bool isHide;

  const SignUpState({
    this.obscureTextPass = true,
    this.obscureTextRePass = true,
    this.obscureText = true,
    this.errorEmail,
    this.errorText = "",
    this.isSignUpSuccess = false,
    this.isHide = false,
  });

  SignUpState copyWith({
    bool? obscureTextPass,
    bool? obscureTextRePass,
    bool? obscureText,
    String? errorEmail,
    String? errorText,
    bool? isSignUpSuccess,
    bool? isHide,
  }) {
    return SignUpState(
      obscureTextPass: obscureTextPass ?? this.obscureTextPass,
      obscureTextRePass: obscureTextRePass ?? this.obscureTextRePass,
      obscureText: obscureText ?? this.obscureText,
      errorEmail: errorEmail,
      errorText: errorText ?? this.errorText,
      isSignUpSuccess: isSignUpSuccess ?? this.isSignUpSuccess,
      isHide: isHide ?? this.isHide,
    );
  }
}
