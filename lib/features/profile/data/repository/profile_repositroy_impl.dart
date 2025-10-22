import 'package:dartz/dartz.dart';
import 'package:fakestoretask/core/errors/failures.dart';
import 'package:fakestoretask/features/auth/data/models/user_model.dart';

import '../../../../core/services/local_storage_service.dart';
import '../../domain/repository/profile_reposiory.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final LocalStorageService localStorageService;

  ProfileRepositoryImpl({required this.localStorageService});

  @override
  Future<Either<Failure, UserModel>> getProfile() async {
    try {
      final userData = localStorageService.getUserData();

      if (userData == null) {
        return Left(CacheFailure(message: 'No user data found'));
      }

      return Right(UserModel.fromJson(userData));
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to get profile: $e'));
    }
  }

  @override
  Future<Either<Failure, bool>> logout() async {
    try {
      await localStorageService.clearUserData();
      return const Right(true);
    } catch (e) {
      return Left(CacheFailure(message: 'Failed to logout: $e'));
    }
  }
}