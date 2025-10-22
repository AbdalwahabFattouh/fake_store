import 'package:dartz/dartz.dart';
import 'package:fakestoretask/core/errors/failures.dart';
import 'package:fakestoretask/features/auth/data/models/user_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, UserModel>> getProfile();

  Future<Either<Failure, bool>> logout();
}