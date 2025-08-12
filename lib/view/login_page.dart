import 'package:dome_ui2/bloc/sign_up_bloc.dart';
import 'package:dome_ui2/bloc/sign_up_state.dart';
import 'package:dome_ui2/color/color.dart';
import 'package:dome_ui2/dialog/dialog.dart';
import 'package:dome_ui2/view/forgot_password.dart';
import 'package:dome_ui2/view/home_page_tab_bar.dart';
import 'package:dome_ui2/view/show_list_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ShowListUserPage(),
              ),
            );
          } else if (state is SignUpError){
            ShowDialog().showFailLogInDialog(context);
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignUpCubit>();

          return Scaffold(
            body: Padding(
              padding: const EdgeInsets.fromLTRB(30, 50, 30, 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Your Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 12),
                    TextField(
                      controller: _passwordController,
                      onChanged: cubit.validatePassword,
                      obscureText: state.obscureText,
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
                            color: state.errorText != ""
                                ? Colors.red
                                : AppColor.color_E1E1E1,
                            width: 2,
                          ),
                        ),
                        suffixIcon: IconButton(
                          onPressed: cubit.statusEye,
                          icon: state.obscureText
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
                          context.read<SignUpCubit>().login(email, password);


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
        },
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
