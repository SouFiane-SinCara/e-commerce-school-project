import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/authentication/domain/repository/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository repository;
  SignUpUseCase({required this.repository});
  Future<Either<SignUpFailures, Account>> call({
    required String email,
    required String fullName,
    required String password,
  }) async {
    return await repository.signUp(
        email: email, password: password, fullName: fullName);
  }
}
