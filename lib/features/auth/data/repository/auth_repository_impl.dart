import 'package:fakestoretask/features/auth/data/datasources/local_auth_datasource.dart';
import 'package:fakestoretask/features/auth/data/datasources/remote_auth_datasource.dart';
import 'package:fakestoretask/features/auth/data/models/user_model.dart';
import 'package:fakestoretask/core/errors/exceptions.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final RemoteAuthDatasource remoteAuthDatasource;
  final LocalAuthDatasource localAuthDatasource;

  AuthRepositoryImpl({
    required this.remoteAuthDatasource,
    required this.localAuthDatasource,
  });

  @override
  Future<UserModel> login(String username, String password) async {
    try {
      final token = await remoteAuthDatasource.login(username, password);
      print(token);
      UserModel user = UserModel(id: 0, email: "", username: username, token: token);
      await localAuthDatasource.saveUser(token, user.toJson());
      return user;
    } on AppException catch (e) {
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<UserModel> register(Map<String, dynamic> userData) async {
    try {
      print("on repo impl register start data");
      print(userData);
      final user = await remoteAuthDatasource.register(userData);
      print("respon in impl register");
      return user;
    } on AppException catch (e) {
      print(e);
      throw ServerException(message: e.message);
    }
  }

  @override
  Future<void> logout() async {
    await localAuthDatasource.clearUser();
  }
}
