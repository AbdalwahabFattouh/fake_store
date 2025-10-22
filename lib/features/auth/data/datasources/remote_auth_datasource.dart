import 'package:fakestoretask/core/constants/api_endpoints.dart';
import 'package:fakestoretask/core/errors/exceptions.dart';
import 'package:fakestoretask/core/network/api_cclient.dart';
import '../models/user_model.dart';

abstract class RemoteAuthDatasource {
  Future<String> login(String username, String password);
  Future<UserModel> register(Map<String, dynamic> userData);
}

class RemoteAuthDatasourceImpl implements RemoteAuthDatasource {
  final ApiClient apiClient;
  RemoteAuthDatasourceImpl({required this.apiClient});

  @override
  Future<String> login(String username, String password) async {
    try {
      final resp = await apiClient.post(
        ApiEndpoints.login,
        data: {'username': username, 'password': password},
      );
      print(resp["token"]);
      return resp["token"];
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      throw ServerException(message: 'Unexpected error: $e');
    }
  }

  @override
  Future<UserModel> register(Map<String, dynamic> userData) async {
    try {
      final data = await apiClient.post(ApiEndpoints.users, data: userData);
      return UserModel.fromJson(data);
    } on AppException catch (e) {
      throw e;
    } catch (e) {
      throw ServerException(message: 'Unexpected error: $e');
    }
  }
}
