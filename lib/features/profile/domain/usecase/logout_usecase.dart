import 'package:dartz/dartz.dart';
import 'package:fakestoretask/core/errors/failures.dart';

import '../repository/profile_reposiory.dart';

class LogoutUseCase {
  final ProfileRepository repository;

  LogoutUseCase(this.repository);

  Future<Either<Failure, bool>> call() async {
    return await repository.logout();
  }
}