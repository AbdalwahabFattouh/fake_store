import 'package:equatable/equatable.dart';
class UserModel extends Equatable {
  final int id;
  final String email;
  final String username;
  final String token;

  const UserModel({
    required this.id,
    required this.email,
    required this.username,
    required this.token,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      email: json['email'] ?? '',
      username: json['username'] ?? '',
      token: json['token'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'username': username,
      'token': token,
    };
  }

  @override
  List<Object?> get props => [id, email, username, token];
}