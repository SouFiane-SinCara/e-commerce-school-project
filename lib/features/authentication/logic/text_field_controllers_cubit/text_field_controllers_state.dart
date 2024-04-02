part of 'text_field_controllers_cubit.dart';

@immutable
sealed class TextFieldControllersState {}

final class TextFieldControllersInitial extends TextFieldControllersState {}
final class UpdateTextFieldsControllersState extends TextFieldControllersState{
  final TextEditingController emailLoginController;
  final TextEditingController passwordLoginController;
  UpdateTextFieldsControllersState({
    required this.emailLoginController,
    required this.passwordLoginController,
  });

}