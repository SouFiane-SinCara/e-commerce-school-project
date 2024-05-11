part of 'Auth_controllers_cubit.dart';

sealed class AuthControllersState extends Equatable {
  const AuthControllersState();

  @override
  List<Object> get props => [];
}

final class AuthControllersInitial extends AuthControllersState {}

final class LoginControllersUpdateState extends AuthControllersState {
  final String email;
  final String password;
  const LoginControllersUpdateState(
      {required this.email, required this.password});
}

final class SignUpControllersUpdateState extends AuthControllersState {
  final String email;
  final String password;
  final String fullName;
  const SignUpControllersUpdateState(
      {required this.email, required this.fullName, required this.password});
}
