part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginEvent extends AuthEvent {
  final String username;
  final String password;

  const LoginEvent(this.username, this.password);
  @override
  List<Object?> get props => [username, password];
}

class RegisterEvent extends AuthEvent {
  final Map<String, dynamic> userData;
  const RegisterEvent(this.userData);
  @override
  List<Object?> get props => [userData];
}

class LogoutEvent extends AuthEvent {}

class ClearErrorEvent extends AuthEvent {}
class CheckLoginStatusEvent extends AuthEvent {}
