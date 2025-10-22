class AppException implements Exception {
  final String message;
  final String code;

  AppException({required this.message, this.code = 'UNKNOWN_ERROR'});
}

class ServerException extends AppException {
  ServerException({super.message = 'Server error occurred'})
    : super(code: 'SERVER_ERROR');
}

class NetworkException extends AppException {
  NetworkException({super.message = 'No internet connection'})
    : super(code: 'NETWORK_ERROR');
}

class AuthenticationException extends AppException {
  AuthenticationException({super.message = 'Authentication failed'})
    : super(code: 'AUTH_ERROR');
}

class CacheException extends AppException {
  CacheException({super.message = 'Cache error occurred'})
    : super(code: 'CACHE_ERROR');
}
