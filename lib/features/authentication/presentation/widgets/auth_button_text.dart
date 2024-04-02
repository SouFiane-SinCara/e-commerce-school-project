import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/features/authentication/logic/text_field_controllers_cubit/text_field_controllers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButtonText extends StatelessWidget {
  final bool? login;
  const AuthButtonText({super.key, this.login});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.themes();
    return BlocBuilder<TextFieldControllersCubit, TextFieldControllersState>(
      builder: (context, state) {
        return Container(
          width: double.infinity,
          height: 50.h,
          decoration: BoxDecoration(
              //todo : adjust dark theme
              boxShadow: [
                BoxShadow(
                    color: theme.shadowColor,
                    offset: Offset.fromDirection(4, -6),
                    blurRadius: 12)
              ],
              color: state is UpdateTextFieldsControllersState &&
                      state.emailLoginController.text.isNotEmpty &&
                      state.passwordLoginController.text.isNotEmpty
                  ? theme.colorScheme.secondary
                  : theme.colorScheme.onSecondary,
              borderRadius: BorderRadius.horizontal(
                  left: Radius.circular(400.h), right: Radius.circular(400.h))),
          alignment: Alignment.center,
          child: FittedBox(
            child: Text(
             context.lang().login,
              style: state is UpdateTextFieldsControllersState &&
                      state.emailLoginController.text.isNotEmpty &&
                      state.passwordLoginController.text.isNotEmpty
                  ? TextStyles.whiteW900(context).copyWith(
                      fontSize: 15.sp,
                    )
                  : TextStyles.whiteW900(context)
                      .copyWith(fontSize: 15.sp, color: Colors.white),
            ),
          ),
        );
      },
    );
  }
}
