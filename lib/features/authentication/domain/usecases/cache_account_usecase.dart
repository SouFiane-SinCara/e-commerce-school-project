import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/authentication/domain/repository/auth_repository.dart';

class CacheAccountUseCase {
  final AuthRepository repository;
  CacheAccountUseCase({required this.repository});
  Future<Either<CacheAccountFailure, Unit>> call({required Account account}) {
    return repository.cacheAccount(account: account);
  }
}
