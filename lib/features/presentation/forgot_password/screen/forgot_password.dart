import 'package:dome_ui2/bloc/forgot_bloc/forgot_bloc.dart';
import 'package:dome_ui2/core/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/forgot_bloc/forgot_state.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPassword();
}

class _ForgotPassword extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotCubit, ForgotState>(
      builder: (context, state) {
        final cubit = context.read<ForgotCubit>();
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Image.asset("assets/images/back.png", width: 32),
                  ),
                  SizedBox(height: 24),
                  Text(
                    "Forgot password",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColor.color_1E1E1E,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Please enter your email to reset the password",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.color_989898,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Your email",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColor.color_2A2A2A,
                    ),
                  ),
                  SizedBox(height: 16),
                  TextField(
                    onChanged: cubit.changeData,
                    decoration: InputDecoration(
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
                      enabledBorder: OutlineInputBorder(
                        // Border khi chưa focus
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(
                          color: AppColor.color_E1E1E1,
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: state.isHide
                            ? AppColor.color_648DDB
                            : AppColor.color_C1D1F1, // Màu nền
                        foregroundColor: Colors.white, // Màu chữ
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12), // Bo góc
                        ),
                      ),
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
