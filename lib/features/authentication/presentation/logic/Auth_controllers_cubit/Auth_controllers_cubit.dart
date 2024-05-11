// ignore_for_file: file_names

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'Auth_controllers_state.dart';

class AuthControllersCubit extends Cubit<AuthControllersState> {
  String emailLogin = "";
  String passwordLogin = "";
  String emailSignUp = "";
  String passwordSignUp = "";
  String fullName = "";
  AuthControllersCubit() : super(AuthControllersInitial());
  void updateLogin({
    String? email,
    String? password,
  }) {
    emit(AuthControllersInitial());
    email == null ? null : emailLogin = email;
    password == null ? null : passwordLogin = password;
    emit(LoginControllersUpdateState(
        email: emailLogin, password: passwordLogin));
  }

  void updateSignUp({String? email, String? password, String? fullName}) {
    emit(AuthControllersInitial());
    email == null ? null : emailSignUp = email;
    password == null ? null : passwordSignUp = password;
    fullName == null ? null : this.fullName = fullName;
    emit(SignUpControllersUpdateState(
        email: emailSignUp, password: passwordSignUp, fullName: this.fullName));
  }
}
