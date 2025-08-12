import 'package:dome_ui2/model/User.dart';
import 'package:flutter/material.dart';

import '../bloc/sign_up_bloc.dart';
import '../color/color.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key, required this.id});
  final String id;

  @override
  State<EditUserPage> createState() => _EditUserPage();
}

class _EditUserPage extends State<EditUserPage> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  late UserModel user;
  late SignUpCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = SignUpCubit();
    _loadUser();
  }

  Future<void> _loadUser() async {
    user = await cubit.getUserById(widget.id);
    setState(() {
      emailController.text = user.email;
      passController.text = user.password;
      nameController.text = user.name;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Material(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              TextField(
                controller: nameController,
                // onChanged: cubit.validateEmail,
                decoration: InputDecoration(
                  // errorText: state.errorEmail,
                  hintText: "Enter your name",
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
                      // color: state.errorEmail != null
                      //     ? Colors.red
                      //     : AppColor.color_E1E1E1,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12,),
              Text(
                "Your Email",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              TextField(
                controller: emailController,
                // onChanged: cubit.validateEmail,
                decoration: InputDecoration(
                  // errorText: state.errorEmail,
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
                      // color: state.errorEmail != null
                      //     ? Colors.red
                      //     : AppColor.color_E1E1E1,
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
                controller: passController,
                // onChanged: cubit.validateEmail,
                decoration: InputDecoration(
                  // errorText: state.errorEmail,
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
                  focusedBorder: OutlineInputBorder(
                    // Border khi chưa focus
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      // color: state.errorEmail != null
                      //     ? Colors.red
                      //     : AppColor.color_E1E1E1,
                      width: 2,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    final email = emailController.text.trim();
                    final password = passController.text.trim();
                    final name = nameController.text.trim();
                    cubit.updateUser(
                      widget.id, // id user
                      {
                        "name": name,
                        "email": email,
                        "password": password,
                      },
                    );

                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.color_648DDB, // Màu nền
                    foregroundColor: Colors.white, // Màu chữ
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12), // Bo góc
                    ),
                  ),
                  child: Text(
                    "Save",
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
  }
}
