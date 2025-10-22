import 'package:fakestoretask/core/services/local_storage_service.dart';

abstract class LocalAuthDatasource {
  Future<void> saveUser(String token, Map<String, dynamic> userData);
  Map<String, dynamic>? getUser();
  Future<String?> getUserToken();
  Future<void> clearUser();
}

class LocalAuthDatasourceImpl implements LocalAuthDatasource {
  final LocalStorageService localStorageService;
  LocalAuthDatasourceImpl({required this.localStorageService});

  @override
  Future<void> clearUser() async {
    await localStorageService.clearUserData();
  }

  @override
  Map<String, dynamic>? getUser() {
    return localStorageService.getUserData();
  }

  @override
  Future<void> saveUser(String token, Map<String, dynamic> userData) async {
    await localStorageService.saveUserToken(token);
    await localStorageService.saveUserData(userData);
  }

  @override
  Future<String?> getUserToken() async {
    return await localStorageService.getUserToken();
  }
}
