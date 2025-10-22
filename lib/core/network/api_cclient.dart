import 'package:dio/dio.dart';
import '../errors/exceptions.dart';
import '../constants/api_endpoints.dart';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio(BaseOptions(
    baseUrl: ApiEndpoints.baseUrl,
    connectTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
    },
  ));

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {

      final response = await _dio.get(endpoint, queryParameters: queryParameters);
      print(response.data);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  Future<dynamic> post(String endpoint, {dynamic data}) async {
    try {
      print("post req in api client");
      final response = await _dio.post(endpoint, data: data);
      return response.data;
    } on DioException catch (e) {
      _handleDioError(e);
    } catch (e) {
      print(e);
      throw ServerException(message: 'Unexpected error: ${e.toString()}');
    }
  }

  void _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw ServerException(message: 'Connection timeout');
      case DioExceptionType.badResponse:
        _handleBadResponse(e);
      case DioExceptionType.cancel:
        throw ServerException(message: 'Request cancelled');
      case DioExceptionType.unknown:
        throw NetworkException(message: 'No internet connection');
      default:
        throw ServerException(message: 'Network error');
    }
  }

  void _handleBadResponse(DioException e) {
    final statusCode = e.response?.statusCode;
    final responseData = e.response?.data;

    if (statusCode == 401) {
      throw AuthenticationException(message: 'Invalid credentials');
    } else if (statusCode == 404) {
      throw ServerException(message: 'Resource not found');
    } else if (statusCode == 500) {
      throw ServerException(message: 'Internal server error');
    } else {
      final errorMessage = responseData is Map ? responseData['message'] ?? 'Unknown error' : 'Unknown error';
      throw ServerException(message: errorMessage);
    }
  }
}