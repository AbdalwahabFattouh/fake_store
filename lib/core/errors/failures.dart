import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  final String code;

  const Failure({required this.message, required this.code});

  @override
  List<Object> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error occurred'})
    : super(code: 'SERVER_ERROR');
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'No internet connection'})
    : super(code: 'NETWORK_ERROR');
}

class AuthenticationFailure extends Failure {
  const AuthenticationFailure({super.message = 'Authentication failed'})
    : super(code: 'AUTH_ERROR');
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error occurred'})
    : super(code: 'CACHE_ERROR');
}
