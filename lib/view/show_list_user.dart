import 'package:dome_ui2/view/edit_user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sign_up_bloc.dart';
import '../bloc/sign_up_state.dart';

class ShowListUserPage extends StatefulWidget {
  const ShowListUserPage({super.key});

  @override
  State<ShowListUserPage> createState() => _ShowListUserPageState();
}

class _ShowListUserPageState extends State<ShowListUserPage> {
  late SignUpCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = SignUpCubit();
    _cubit.getListData(); // Gọi API 1 lần
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _cubit,
      child: Scaffold(
        body: BlocBuilder<SignUpCubit, SignUpState>(
          builder: (context, state) {
            if (state is SignUpSuccess) {
              return SafeArea(
                child: ListView.builder(
                  padding: const EdgeInsets.all(6),
                  itemCount: state.users.length,
                  itemBuilder: (BuildContext context, int index) {
                    final user = state.users[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => EditUserPage(id : user.id)),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.blue,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    user.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 100,
                                    height: 100,
                                    child: Image.network(
                                      user.avatar,
                                      fit: BoxFit.cover,
                                      loadingBuilder: (context, child, progress) {
                                        if (progress == null) return child;
                                        return Center(child: CircularProgressIndicator());
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Icon(Icons.error);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            } else if (state is SignUpLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return const Center(child: Text("Không có dữ liệu"));
            }
          },
        ),
      ),
    );
  }
}
