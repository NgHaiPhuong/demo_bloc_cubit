import 'package:dome_ui2/features/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:dome_ui2/features/presentation/show_list/bloc/show_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../edit_user/screen/edit_user.dart';

class ShowListUserPage extends StatefulWidget {
  const ShowListUserPage({super.key});

  @override
  State<ShowListUserPage> createState() => _ShowListUserPageState();
}

class _ShowListUserPageState extends State<ShowListUserPage> {
  @override
  void initState() {
    super.initState();
    context.read<ShowListCubit>().getListData(); // Gọi API 1 lần
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowListCubit, ShowListState>(
      builder: (context, state) {
        if (state is ShowListSuccess) {
          return SafeArea(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: const EdgeInsets.all(6),
                itemCount: state.users.length,
                itemBuilder: (BuildContext context, int index) {
                  final user = state.users[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditUserPage(userModel: user),
                        ),
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
                                    fontSize: 14,
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
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
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
            ),
          );
        } else if (state is ShowListLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text("Không có dữ liệu"));
        }
      },
    );
  }
}
