import 'package:dome_ui2/core/utils/color.dart';
import 'package:dome_ui2/core/utils/dialog.dart';
import 'package:dome_ui2/features/presentation/signup/provider/sign_up_provider.dart';
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
    final provider = context.watch<SignUpProvider>();

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
              onChanged: provider.validateEmail,
              decoration: InputDecoration(
                errorText: provider.errorEmail,
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
                    color: provider.errorEmail != null
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
                    provider.errorText ?? "",
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
                  
                  provider.register(email, password);
                  ShowDialog().showLoginSuccessDialog(context, "Đăng nhập thành công");
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
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget textPassword(String text, bool isEnterPass) {
    final provider = context.watch<SignUpProvider>();

    return TextField(
      controller: isEnterPass ? enterPassController : re_enterPassController,
      onChanged: (value) {
        if (isEnterPass) {
          provider.validatePassword(value);
        } else {
          provider.validateRePassword(
            enterPassController.text,
            value, // đây là rePass hiện tại
          );
        }
      },
      obscureText: isEnterPass
          ? provider.obscureTextPass
          : provider.obscureTextRePass,
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
          borderSide: const BorderSide(color: AppColor.color_E1E1E1, width: 2),
        ),
        focusedBorder: OutlineInputBorder(
          // Border khi chưa focus
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: provider.errorText != ""
                ? Colors.red
                : AppColor.color_E1E1E1,
            width: 2,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () => provider.togglePasswordVisibility(isEnterPass),
          icon: Icon(
            getVisibilityIcon(
              isEnterPass,
              provider.obscureTextPass,
              provider.obscureTextRePass,
            ),
          ),
        ),
      ),
    );
  }

  IconData getVisibilityIcon(
    bool isEnterPass,
    obscureTextPass,
    obscureTextRePass,
  ) {
    final isObscured = isEnterPass ? obscureTextPass : obscureTextRePass;
    return isObscured
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
  }
}
