import 'package:equatable/equatable.dart';
import 'package:fakestoretask/core/utils/app_enum.dart';
import 'package:fakestoretask/features/auth/data/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fakestoretask/features/auth/domain/usecases/login_usercase.dart';
import 'package:fakestoretask/features/auth/domain/usecases/register_usecase.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/services/local_storage_service.dart';
import '../../../../core/services/injection_container.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LocalStorageService localStorageService = sl<LocalStorageService>();

  AuthBloc({required this.loginUseCase, required this.registerUseCase})
    : super(
        AuthState(
          status: BlocStatus.initial,
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
          nameController: TextEditingController(),
        ),
      ) {
    on<LoginEvent>(_onLogin);
    on<RegisterEvent>(_onRegister);
    on<LogoutEvent>(_onLogout);
    on<ClearErrorEvent>(_onClearError);
    on<CheckLoginStatusEvent>(_onCheckLoginStatus);
  }

  Future<void> _onLogin(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading, errorMessage: null));

    try {
      final user = await loginUseCase(event.username, event.password);
      await localStorageService.saveUserData(user.toJson());
      await localStorageService.saveUserToken(user.token);

      emit(
        state.copyWith(
          status: BlocStatus.success,
          user: user,
          isLoggedIn: true,
        ),
      );
    } on Failure catch (e) {
      emit(state.copyWith(status: BlocStatus.failed, errorMessage: e.message));
    } catch (_) {
      emit(
        state.copyWith(
          status: BlocStatus.failed,
          errorMessage: 'Unexpected error',
        ),
      );
    }
  }

  Future<void> _onRegister(RegisterEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: BlocStatus.loading, errorMessage: null));
    try {
      await registerUseCase(event.userData);

      await localStorageService.saveUserData(event.userData);

      emit(state.copyWith(status: BlocStatus.success, isLoggedIn: true));
    } on Failure catch (e) {
      emit(state.copyWith(status: BlocStatus.failed, errorMessage: e.message));
    } catch (_) {
      emit(
        state.copyWith(
          status: BlocStatus.failed,
          errorMessage: 'Unexpected error',
        ),
      );
    }
  }

  Future<void> _onCheckLoginStatus(
      CheckLoginStatusEvent event,
      Emitter<AuthState> emit,
      ) async {
    emit(state.copyWith(status: BlocStatus.loading));

    final isLoggedIn = await localStorageService.isUserLoggedIn();
    final userData = localStorageService.getUserData();
    print("in auth");
    print(isLoggedIn);
    print(userData);
    emit(state.copyWith(
      status: BlocStatus.success,
      isLoggedIn: isLoggedIn,
      user: isLoggedIn && userData != null
          ? UserModel.fromJson(userData)
          : null,
    ));

    // بعد فحص الحالة، ننتظر 3 ثوانٍ مثلاً ثم ننتقل
    await Future.delayed(const Duration(seconds: 3));
    emit(state.copyWith(splashCompleted: true));
  }




  void _onLogout(LogoutEvent event, Emitter<AuthState> emit) async {
    await localStorageService.clearUserData();
    emit(
      state.copyWith(
        status: BlocStatus.initial,
        user: null,
        isLoggedIn: false,
        errorMessage: null,
      ),
    );
  }

  void _onClearError(ClearErrorEvent event, Emitter<AuthState> emit) {
    emit(state.copyWith(errorMessage: null));
  }
}
