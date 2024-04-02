import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';  

part 'text_field_controllers_state.dart';

class TextFieldControllersCubit extends Cubit<TextFieldControllersState> {
  TextEditingController emailLoginController = TextEditingController();
  TextEditingController passwordLoginController = TextEditingController();

  TextFieldControllersCubit() : super(TextFieldControllersInitial());
  void updateController(
      String controllerKey, TextEditingController textEditingController) {
    emit(TextFieldControllersInitial());
    if (controllerKey == "loginEmail") {
      emailLoginController = textEditingController;
    } else if (controllerKey == "loginPassword") {
      passwordLoginController = textEditingController;
    }
    emit(UpdateTextFieldsControllersState(
        emailLoginController: emailLoginController,
        passwordLoginController: passwordLoginController));
  }
}
