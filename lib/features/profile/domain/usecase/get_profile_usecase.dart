import 'package:dartz/dartz.dart';
import 'package:fakestoretask/core/errors/failures.dart';
import 'package:fakestoretask/features/auth/data/models/user_model.dart';

import '../repository/profile_reposiory.dart';

class GetProfileUseCase {
  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, UserModel>> call() async {
    return await repository.getProfile();
  }
}