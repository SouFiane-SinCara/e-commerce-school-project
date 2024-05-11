import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/data/repository_imp/auth_repository_imp.dart';
import 'package:e_commerce_school_project/features/authentication/data/sources/auth_local_data_source.dart';
import 'package:e_commerce_school_project/features/authentication/data/sources/auth_remote_data_source.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/authentication/domain/usecases/cache_account_usecase.dart';
import 'package:e_commerce_school_project/features/authentication/domain/usecases/forgot_password_usecase.dart';
import 'package:e_commerce_school_project/features/authentication/domain/usecases/get_cached_account_usecase.dart';
import 'package:e_commerce_school_project/features/authentication/domain/usecases/login_usecase.dart';
import 'package:e_commerce_school_project/features/authentication/domain/usecases/signup_usecase.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
part 'Auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  Account? account;
  AuthCubit() : super(AuthLoadingState());

  Future<void> signUp(
    String email,
    String fullName,
    String password,
  ) async {
    emit(AuthLoadingState());
    SignUpUseCase signUpUseCase = SignUpUseCase(
        repository: AuthRepositoryImp(
            authRemoteDataSource: AuthRemoteDataSourceImp(),
            authLocalDataSource: AuthLocalDataSourceHive()));
    CacheAccountUseCase cacheAccountUseCase = CacheAccountUseCase(
        repository: AuthRepositoryImp(
            authLocalDataSource: AuthLocalDataSourceHive(),
            authRemoteDataSource: AuthRemoteDataSourceImp()));
    Either<SignUpFailures, Account> response = await signUpUseCase.call(
        email: email, fullName: fullName, password: password);
    response.fold(
      (failure) => emit(SignUpErrorState(failure: failure)),
      (account) async {
        await cacheAccountUseCase.call(account: account);
        this.account = account;

        emit(SignUpSuccessState(account: account));
      },
    );
  }

  Future<void> login(
      {required String email,
      required String password,
      required BuildContext context}) async {
    emit(AuthLoadingState());
    LoginUseCase loginUseCase = LoginUseCase(
        repository: AuthRepositoryImp(
            authRemoteDataSource: AuthRemoteDataSourceImp(),
            authLocalDataSource: AuthLocalDataSourceHive()));
    CacheAccountUseCase cacheAccountUseCase = CacheAccountUseCase(
        repository: AuthRepositoryImp(
            authLocalDataSource: AuthLocalDataSourceHive(),
            authRemoteDataSource: AuthRemoteDataSourceImp()));

    Either<LoginFailures, Account> response =
        await loginUseCase.call(email: email, password: password);
    response.fold((failure) {
      print("$failure");
      emit(LoginErrorState(failure: failure));
    }, (account) async {
      await cacheAccountUseCase.call(account: account);
      this.account = account;
      emit(LoginSuccessState(account: account));
    });
  }

  Future<void> getCachedAccount() async {
    emit(AuthLoadingState());

    GetCacheAccountUseCase getCacheAccountUseCase = GetCacheAccountUseCase(
        repository: AuthRepositoryImp(
      authRemoteDataSource: AuthRemoteDataSourceImp(),
      authLocalDataSource: AuthLocalDataSourceHive(),
    ));
    Either<CacheAccountFailure, Account> response =
        await getCacheAccountUseCase.call();
    response.fold((empity) {
      emit(AuthInitialState());
    }, (account) {
      this.account = account;
      emit(LoginSuccessState(account: account));
    });
  }

  Future<void> forgotPassword({required String email}) async {
    emit(ForgotPasswordProcessingState());
    ForgotPasswordUseCase forgotPasswordUseCase = ForgotPasswordUseCase(
        authRepository: AuthRepositoryImp(
            authLocalDataSource: AuthLocalDataSourceHive(),
            authRemoteDataSource: AuthRemoteDataSourceImp()));
    final response = await forgotPasswordUseCase.call(email: email);
    response.fold((fail) {
      emit(ErrorForgotPasswordState(failure: fail));
    }, (done) {
      emit(ForgotPasswordSentState());
    });
  }
}
