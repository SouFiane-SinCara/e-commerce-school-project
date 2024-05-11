import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';

abstract class AuthRepository {
  Future<Either<LoginFailures, Account>> login({
    required String email,
    required String password,
  });
  Future<Either<SignUpFailures, Account>> signUp({
    required String email,
    required String fullName,
    required String password,
  });
  Future<Either<CacheAccountFailure, Unit>> cacheAccount(
      {required Account account});
  Future<Either<CacheAccountFailure, Account>> getCacheAccount();
  Future<Either<ForgotPasswordFailure, Unit>> forgotPassword(
      {required String email});
}
