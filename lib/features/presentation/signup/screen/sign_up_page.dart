import 'package:dome_ui2/core/utils/color.dart';
import 'package:dome_ui2/features/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:dome_ui2/features/presentation/signup/bloc/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPage();
}

class _SignUpPage extends State<SignUpPage> {
  TextEditingController enterPassController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController re_enterPassController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          final cubit = context.read<SignUpCubit>();

          return Padding(
            padding: const EdgeInsets.fromLTRB(30, 50, 30, 16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your Email",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  TextField(
                    controller: emailController,
                    onChanged: cubit.validateEmail,
                    decoration: InputDecoration(
                      errorText: state.errorEmail,
                      hintText: "Enter your email",
                      hintStyle: TextStyle(color: AppColor.color_B3B3B3),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 14,
                        horizontal: 21,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: AppColor.color_E1E1E1,
                          width: 2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        // Border khi chưa focus
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(
                          color: state.errorEmail != null
                              ? Colors.red
                              : AppColor.color_E1E1E1,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  textPassword("Enter your password", true),
                  SizedBox(height: 12),
                  Text(
                    "Confirm Password",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 12),
                  textPassword("Re-enter password", false),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          state.errorText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {
                        final email = emailController.text.trim();
                        final password = enterPassController.text.trim();
                        cubit.signUp(context, email, password);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.color_648DDB, // Màu nền
                        foregroundColor: Colors.white, // Màu chữ
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Bo góc
                        ),
                      ),
                      child: Text(
                        "Sign up",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget textPassword(String text, bool isEnterPass) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();

        return TextField(
          controller: isEnterPass
              ? enterPassController
              : re_enterPassController,
          onChanged: (value) {
            if (isEnterPass) {
              cubit.validatePassword(value);
            } else {
              cubit.validateRePassword(
                enterPassController.text,
                value, // đây là rePass hiện tại
              );
            }
          },
          obscureText: isEnterPass
              ? state.obscureTextPass
              : state.obscureTextRePass,
          decoration: InputDecoration(
            // errorText: _errorText,
            hintText: text,
            hintStyle: TextStyle(color: AppColor.color_B3B3B3),
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 21),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: AppColor.color_E1E1E1, width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              // Border khi chưa focus
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: AppColor.color_E1E1E1,
                width: 2,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              // Border khi chưa focus
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(
                color: state.errorText != ""
                    ? Colors.red
                    : AppColor.color_E1E1E1,
                width: 2,
              ),
            ),
            suffixIcon: IconButton(
              onPressed: () => cubit.togglePasswordVisibility(isEnterPass),
              icon: Icon(
                getVisibilityIcon(
                  isEnterPass,
                  state.obscureTextPass,
                  state.obscureTextRePass,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  IconData getVisibilityIcon(
    bool isEnterPass,
    _obscureTextPass,
    _obscureTextRePass,
  ) {
    final isObscured = isEnterPass ? _obscureTextPass : _obscureTextRePass;
    return isObscured
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
  }
}
