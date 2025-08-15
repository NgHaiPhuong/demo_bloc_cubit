import 'package:dome_ui2/features/data/models/user.dart';
import 'package:dome_ui2/features/domain/repositories/user_repository.dart';

class ShowListUserCase {
  final UserRepository repository;

  ShowListUserCase(this.repository);

  Future<List<UserModel>> call() async {
    return await repository.getListData();
  }
}
