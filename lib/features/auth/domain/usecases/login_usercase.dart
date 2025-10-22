import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../data/models/user_model.dart';
import '../repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);
  Future<UserModel> call(String username, String password) async {
    try {
      return await repository.login(username, password);
    } on AppException catch (e) {
      throw ServerFailure(message: e.message);
    }
  }
}