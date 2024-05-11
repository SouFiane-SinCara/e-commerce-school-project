part of 'Auth_cubit.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitialState extends AuthState {}

final class AuthLoadingState extends AuthState {}

class SignUpErrorState extends AuthState {
  final Failures failure;
  const SignUpErrorState({required this.failure});
}

class SignUpSuccessState extends AuthState {
  final Account account;
  const SignUpSuccessState({required this.account});
}

class LoginErrorState extends AuthState {
  final Failures failure;
  const LoginErrorState({required this.failure});
}

class LoginSuccessState extends AuthState {
  final Account account;
  const LoginSuccessState({required this.account});
}

class ErrorForgotPasswordState extends AuthState {
  final ForgotPasswordFailure failure;
  const ErrorForgotPasswordState({required this.failure});
}

class ForgotPasswordSentState extends AuthState {}

class ForgotPasswordProcessingState extends AuthState {}
