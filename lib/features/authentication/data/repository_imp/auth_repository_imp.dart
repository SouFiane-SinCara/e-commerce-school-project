import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/exceptions.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/data/models/account_model.dart';
import 'package:e_commerce_school_project/features/authentication/data/sources/auth_local_data_source.dart';
import 'package:e_commerce_school_project/features/authentication/data/sources/auth_remote_data_source.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/authentication/domain/repository/auth_repository.dart';

class AuthRepositoryImp extends AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthLocalDataSource authLocalDataSource;
  AuthRepositoryImp(
      {required this.authRemoteDataSource, required this.authLocalDataSource});

  @override
  Future<Either<LoginFailures, Account>> login({
    required String email,
    required String password,
  }) async {
    try {
      Account account =
          await authRemoteDataSource.login(email: email, password: password);
      return Right(account);
    } on ServerException {
      return Left(ServerLoginFailure());
    } on EmailBadFormatException {
      return Left(EmailBadFormatLoginFailure());
    } on WeakPasswordException {
      return Left(WeakPasswordLoginFailure());
    } on WrongPasswordOrEmailException {
      return Left(WrongPasswordOrEmailFailure());
    }
  }

  @override
  Future<Either<SignUpFailures, Account>> signUp({
    required String email,
    required String fullName,
    required String password,
  }) async {
    try {
      Account account = await authRemoteDataSource.signUP(
          email: email, fullName: fullName, password: password);
      return Right(account);
    } on ServerException {
      return Left(ServerSignUpFailure());
    } on WeakPasswordException {
      return Left(WeakPasswordSignUpFailure());
    } on NonInternetConnectionException {
      return Left(NonInternetConnectionFailure());
    } on EmailBadFormatException {
      return Left(EmailBadFormatSignUpFailure());
    } on EmailAlreadyUsedException {
      return Left(EmailAlreadyUsedFailure());
    }
  }

  @override
  Future<Either<GeneralCacheAccountFailure, Unit>> cacheAccount(
      {required Account account}) async {
    try {
      await authLocalDataSource.cacheAccount(
          account: AccountModel(
              fullName: account.fullName,
              email: account.email,
              password: account.password,
              userId: account.userId));
      return const Right(unit);
    } catch (e) {
      return Left(GeneralCacheAccountFailure());
    }
  }

  @override
  Future<Either<CacheAccountFailure, Account>> getCacheAccount() async {
    try {
      Account account = await authLocalDataSource.getCacheAccount();
      return Right(account);
    } on EmptyCacheAccountException {
      return Left(EmptyCacheAccountFailure());
    } on CacheAccountException {
      return Left(GeneralCacheAccountFailure());
    }
  }

  @override
  Future<Either<ForgotPasswordFailure, Unit>> forgotPassword(
      {required String email}) async {
    try {
      await authRemoteDataSource.forgotPassword(email: email);
      return const Right(unit);
    } on ServerException {
      return Left(ServerForgotPasswordFailure());
    } on NotRegisteredException {
      return Left(NotRegisterFailure());
    } on EmailBadFormatException {
      return Left(EmailBadFormatForgotPasswordFailure());
    }
  }
}
