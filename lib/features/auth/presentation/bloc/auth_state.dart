part of 'auth_bloc.dart';

class AuthState extends Equatable {
  final BlocStatus status;
  final UserModel? user;
  final String? errorMessage;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController nameController;
  final bool isLoggedIn;
  final bool splashCompleted;

  const AuthState({
    required this.status,
    this.user,
    this.errorMessage,
    required this.emailController,
    required this.passwordController,
    required this.nameController,
    this.isLoggedIn = false,
    this.splashCompleted = false,
  });

  AuthState copyWith({
    BlocStatus? status,
    UserModel? user,
    String? errorMessage,
    TextEditingController? emailController,
    TextEditingController? passwordController,
    TextEditingController? nameController,
    bool? isLoggedIn,
    bool? splashCompleted,
  }) {
    return AuthState(
      status: status ?? this.status,
      user: user ?? this.user,
      errorMessage: errorMessage ?? this.errorMessage,
      emailController: emailController ?? this.emailController,
      passwordController: passwordController ?? this.passwordController,
      nameController: nameController ?? this.nameController,
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      splashCompleted: splashCompleted ?? this.splashCompleted
    );
  }

  @override
  List<Object?> get props => [
    status,
    user,
    errorMessage,
    emailController,
    passwordController,
    nameController,
    isLoggedIn,
    splashCompleted,

  ];
}