import 'package:dome_ui2/bloc/edit_user_bloc/edit_user_bloc.dart';
import 'package:dome_ui2/bloc/log_in_bloc/log_in_bloc.dart';
import 'package:dome_ui2/bloc/show_list_bloc/show_list_bloc.dart';
import 'package:dome_ui2/bloc/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../presentation/home/screen/home_page_tab_bar.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Nền trắng
    ),
  );

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => EditUserCubit()),
    BlocProvider(create: (_) => LogInCubit()),
    BlocProvider(create: (_) => ShowListCubit()),
    BlocProvider(create: (_) => SignUpCubit()),
  ], child:  const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(currentTab: 0),
    );
  }
}
