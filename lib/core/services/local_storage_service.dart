import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/app_constants.dart';
import '../errors/exceptions.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();
  factory LocalStorageService() => _instance;
  LocalStorageService._internal();

  late SharedPreferences _prefs;

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<void> saveUserToken(String token) async {
    try {
      await _prefs.setString(AppConstants.tokenKey, token);
    } catch (e) {
      throw CacheException(message: 'Failed to save token');
    }
  }

  Future<String?> getUserToken() async {
    try {
      return _prefs.getString(AppConstants.tokenKey);
    } catch (e) {
      throw CacheException(message: 'Failed to get token');
    }
  }

  Future<void> saveUserData(Map<String, dynamic> userData) async {
    try {
      print("on saveUserData ");
      print(json.encode(userData));
      await _prefs.setString(AppConstants.userDataKey, json.encode(userData));
    } catch (e) {
      throw CacheException(message: 'Failed to save user data');
    }
  }

  Map<String, dynamic>? getUserData() {
    try {
      final userData = _prefs.getString(AppConstants.userDataKey);
      print("on get user data string");
      print(userData);
      if (userData != null) {
        return json.decode(userData) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      throw CacheException(message: 'Failed to get user data');
    }
  }

  Future<void> clearUserData() async {
    try {
      await _prefs.remove(AppConstants.tokenKey);
      await _prefs.remove(AppConstants.userDataKey);
    } catch (e) {
      throw CacheException(message: 'Failed to clear user data');
    }
  }

  Future<bool> isUserLoggedIn() async {
    try {
      final token = await getUserToken();
      final userData = getUserData();
      return token != null && userData != null;
    } catch (e) {
      return false;
    }
  }
}
