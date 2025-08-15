import 'package:dome_ui2/features/data/models/user.dart';
import 'package:dome_ui2/features/domain/repositories/user_repository.dart';

class SignUpUserCase {
  final UserRepository repository;

  SignUpUserCase(this.repository);

  Future<UserModel> call(String email, String password) async {
    return await repository.register(email, password);
  }
}
