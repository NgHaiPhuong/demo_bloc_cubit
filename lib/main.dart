import 'package:dome_ui2/features/data/datasources/user_data_sources.dart';
import 'package:dome_ui2/features/data/repositories/user_repository_impl.dart';
import 'package:dome_ui2/features/domain/usecases/log_in.dart';
import 'package:dome_ui2/features/domain/usecases/show_list.dart';
import 'package:dome_ui2/features/domain/usecases/sign_up.dart';
import 'package:dome_ui2/features/domain/usecases/update_user.dart';
import 'package:dome_ui2/features/presentation/edit_user/provider/edit_user_provider.dart';
import 'package:dome_ui2/features/presentation/forgot_password/provider/forgot_provider.dart';
import 'package:dome_ui2/features/presentation/home/screen/home_page_tab_bar.dart';
import 'package:dome_ui2/features/presentation/login/provider/log_in_provider.dart';
import 'package:dome_ui2/features/presentation/show_list/provider/show_list_provider.dart';
import 'package:dome_ui2/features/presentation/signup/provider/sign_up_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LogInProvider(logInUserCase)),
        ChangeNotifierProvider(create: (_) => ShowListProvider(showListUserCase),),
        ChangeNotifierProvider(create: (_) => EditUserProvider(updateUserUseCase),),
        ChangeNotifierProvider(create: (_) => ForgotProvider()),
        ChangeNotifierProvider(create: (_) => SignUpProvider(signUpUserCase)),
      ],
      child: const MyApp(),
    ),
  );
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
