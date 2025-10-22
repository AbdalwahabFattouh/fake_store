part of 'profile_bloc.dart';

class ProfileState {
  final String? errorMessage;
  final UserModel? user;
  final BlocStatus status;

  ProfileState({
    this.errorMessage,
    this.user,
    this.status = BlocStatus.initial,
  });

  ProfileState copyWith({
    String? errorMessage,
    UserModel? user,
    BlocStatus? status,
  }) {
    return ProfileState(
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
      status: status ?? this.status,
    );
  }
}