import '../../data/models/user_model.dart';

abstract class AuthRepository {
  Future<UserModel> login(String username, String password);
  Future<UserModel> register(Map<String, dynamic> userData);
  Future<void> logout();
}
