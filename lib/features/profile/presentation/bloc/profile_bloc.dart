import 'package:equatable/equatable.dart';
import 'package:fakestoretask/core/utils/app_enum.dart';
import 'package:fakestoretask/features/auth/data/models/user_model.dart';
import 'package:fakestoretask/features/profile/domain/usecase/get_profile_usecase.dart';
import 'package:fakestoretask/features/profile/domain/usecase/logout_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfileUseCase;
  final LogoutUseCase logoutUseCase;

  ProfileBloc({
    required this.logoutUseCase,
    required this.getProfileUseCase,
  }) : super(ProfileState()) {
    on<LoadProfileEvent>(_loadProfileEvent);
    on<LogoutEvent>(_logoutEvent);
  }

  Future<void> _loadProfileEvent(
      LoadProfileEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(status: BlocStatus.loading));

    final result = await getProfileUseCase();

    result.fold(
          (failure) {
        emit(state.copyWith(
          status: BlocStatus.failed,
          errorMessage: failure.message,
        ));
      },
          (user) {
        emit(state.copyWith(
          status: BlocStatus.success,
          user: user,
          errorMessage: null,
        ));
      },
    );
  }

  Future<void> _logoutEvent(
      LogoutEvent event,
      Emitter<ProfileState> emit,
      ) async {
    emit(state.copyWith(status: BlocStatus.loading));

    final result = await logoutUseCase();

    result.fold(
          (failure) {
        emit(state.copyWith(
          status: BlocStatus.failed,
          errorMessage: failure.message,
        ));
      },
          (success) {
        emit(state.copyWith(
          status: BlocStatus.initial,
          user: null,
          errorMessage: null,
        ));
      },
    );
  }
}