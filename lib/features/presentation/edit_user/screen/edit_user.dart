import 'package:dome_ui2/core/utils/color.dart';
import 'package:dome_ui2/features/presentation/edit_user/bloc/edit_user_bloc.dart';
import 'package:dome_ui2/features/presentation/edit_user/bloc/edit_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user.dart';

class EditUserPage extends StatefulWidget {
  const EditUserPage({super.key, required this.userModel});

  final UserModel userModel;

  @override
  State<EditUserPage> createState() => _EditUserPage();
}

class _EditUserPage extends State<EditUserPage> {
  TextEditingController passController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    passController.text = widget.userModel.password;
    emailController.text = widget.userModel.email;
    nameController.text = widget.userModel.name;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditUserCubit, EditUserState>(
      listener: (context, state) {
        if (state is EditUserSuccess) {
          Navigator.pop(context);
        } else if (state is EditUserError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.error)));
        }
      },
      builder: (context, state) {
        final cubit = context.read<EditUserCubit>();

        return SafeArea(
          child: Scaffold(
            body: Padding(
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
                  SizedBox(height: 12),
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
                        cubit.updateUser(
                          widget.userModel.id, // id user
                          {
                            "name": nameController.text.trim(),
                            "avatar": widget.userModel.avatar,
                            "email": emailController.text.trim(),
                            "password": passController.text.trim(),
                            "id": widget.userModel.id,
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
      },
    );
  }
}
