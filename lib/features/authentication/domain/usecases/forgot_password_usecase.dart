import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/repository/auth_repository.dart';

class ForgotPasswordUseCase {
  AuthRepository authRepository;
  ForgotPasswordUseCase({required this.authRepository});
  Future<Either<ForgotPasswordFailure, Unit>> call({required String email}) {
    return authRepository.forgotPassword(email: email);
  }
}
