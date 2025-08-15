import 'package:dome_ui2/features/data/datasources/user_data_sources.dart';
import 'package:dome_ui2/features/data/repositories/user_repository_impl.dart';
import 'package:dome_ui2/features/domain/usecases/log_in.dart';
import 'package:dome_ui2/features/domain/usecases/show_list.dart';
import 'package:dome_ui2/features/domain/usecases/sign_up.dart';
import 'package:dome_ui2/features/domain/usecases/update_user.dart';
import 'package:dome_ui2/features/presentation/edit_user/bloc/edit_user_bloc.dart';
import 'package:dome_ui2/features/presentation/home/screen/home_page_tab_bar.dart';
import 'package:dome_ui2/features/presentation/login/bloc/log_in_bloc.dart';
import 'package:dome_ui2/features/presentation/show_list/bloc/show_list_bloc.dart';
import 'package:dome_ui2/features/presentation/signup/bloc/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.white, // Nền trắng
    ),
  );

  final userRemoteDataSource = UserRemoteDataSource();
  final userRepository = UserRepositoryImpl(userRemoteDataSource);

  final updateUserUseCase = UpdateUser(userRepository);
  final logInUserCase = LogInUserCase(userRepository);
  final showListUserCase = ShowListUserCase(userRepository);
  final signUpUserCase = SignUpUserCase(userRepository);

  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (_) => EditUserCubit(updateUserUseCase)),
    BlocProvider(create: (_) => LogInCubit(logInUserCase)),
    BlocProvider(create: (_) => ShowListCubit(showListUserCase)),
    BlocProvider(create: (_) => SignUpCubit(signUpUserCase)),
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
