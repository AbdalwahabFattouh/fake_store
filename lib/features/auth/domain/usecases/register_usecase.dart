import 'package:fakestoretask/core/errors/exceptions.dart';
import 'package:fakestoretask/core/errors/failures.dart';

import '../repositories/auth_repository.dart';
import '../../data/models/user_model.dart';

class RegisterUseCase {
  final AuthRepository repository;
  RegisterUseCase(this.repository);

  Future<UserModel> call(Map<String, dynamic> userData) async {
    try{
      return await repository.register(userData);
    }on AppException catch(e){
      throw ServerFailure(message:  e.message);
    }
  }
}
