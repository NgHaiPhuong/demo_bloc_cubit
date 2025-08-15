import 'package:dome_ui2/core/utils/color.dart';
import 'package:dome_ui2/core/utils/dialog.dart';
import 'package:dome_ui2/features/presentation/login/provider/log_in_provider.dart';
import 'package:dome_ui2/features/presentation/show_list/screen/show_list_user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../forgot_password/screen/forgot_password.dart';
import '../../home/screen/home_page_tab_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LogInProvider>();

    // Lắng nghe và điều hướng khi đăng nhập thành công
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (provider.message == "Đăng nhập thành công") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ShowListUserPage(),
          ),
        );
      } else if (provider.message != null &&
          provider.message!.startsWith("Lỗi")) {
        ShowDialog().showFailLogInDialog(context);
      }
    });

    return Scaffold(
      body: Padding(
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
                controller: _emailController,
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
              SizedBox(height: 16),
              Text(
                "Password",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                onChanged: provider.validatePassword,
                obscureText: provider.obscureText,
                decoration: InputDecoration(
                  // errorText: _errorText,
                  hintText: "Enter your password",
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
                    onPressed: provider.statusEye,
                    icon: provider.obscureText
                        ? Icon(Icons.visibility_off_outlined)
                        : Icon(Icons.visibility_outlined),
                  ),
                ),
              ),
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
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ForgotPassword(),
                        ),
                      );
                    },
                    child: Text(
                      "Forgot password?",
                      style: TextStyle(
                        color: AppColor.color_648DDB,
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
                    final email = _emailController.text.trim();
                    final password = _passwordController.text.trim();
                    provider.login(email, password);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.color_648DDB, // Màu nền
                    foregroundColor: Colors.white, // Màu chữ
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bo góc
                    ),
                  ),
                  child: Text(
                    "Continue",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Divider(
                      color: AppColor.color_E1E1E1,
                      thickness: 2,
                      indent: 16,
                      endIndent: 16,
                      height: 32,
                    ),
                  ),
                  Text(
                    "Or",
                    style: TextStyle(color: AppColor.color_E1E1E1),
                  ),
                  Expanded(
                    child: Divider(
                      color: AppColor.color_E1E1E1,
                      thickness: 2,
                      indent: 16,
                      endIndent: 16,
                      height: 32,
                    ),
                  ),
                  // Container(width: 100, height: 2, color: AppColor.color_E1E1E1,),
                ],
              ),
              SizedBox(height: 22),
              btnLogin('assets/images/apple.png', 'Login with Apple'),
              SizedBox(height: 16),
              btnLogin('assets/images/google.png', 'Login with Google'),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don’t have an account?",
                    style: TextStyle(color: AppColor.color_989898),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyHomePage(currentTab: 1),
                        ),
                      );
                    },
                    child: Text(
                      " Sign up",
                      style: TextStyle(color: AppColor.color_648DDB),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget btnLogin(String icon, String text) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.white, // Màu nền
          shape: RoundedRectangleBorder(
            side: BorderSide(color: AppColor.color_E1E1E1, width: 2),
            borderRadius: BorderRadius.circular(12), // Bo góc
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(icon),
            SizedBox(width: 16),
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: AppColor.color_2A2A2A,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
