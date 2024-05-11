import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/core/widgets/my_text_field.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_cubit/Auth_cubit.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/widgets/auth_button_text.dart';
import 'package:e_commerce_school_project/features/multi_language/presentation/widgets/multi_language_changer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations lang = AppLocalizations.of(context)!;
    ThemeData theme = context.themes();

    String getFailureMessage(Failures failure) {
      switch (failure.runtimeType) {
        case const (ServerLoginFailure):
          return lang.serverLoginFailure;
        case const (EmailBadFormatLoginFailure):
          return lang.emailBadFormatFailure;
        case const (WrongPasswordOrEmailFailure):
          return lang.wrongPasswordOrEmailFailure;
        case const (WeakPasswordLoginFailure):
          return lang.weakPasswordFailure;
        case const (ServerSignUpFailure):
          return lang.serverSignUpFailure;
        case const (EmailAlreadyUsedFailure):
          return lang.emailAlreadyUsedFailure;
        case const (WeakPasswordSignUpFailure):
          return lang.weakPasswordFailure;
        case const (NonInternetConnectionFailure):
          return lang.nonInternetConnectionFailure;
        case const (EmailBadFormatSignUpFailure):
          return lang.emailBadFormatFailure;
        case const (EmailBadFormatForgotPasswordFailure):
          return lang.emailBadFormatFailure;
        case const (NotRegisterFailure):
          return lang.accountNotRegistered;
        case const (ServerForgotPasswordFailure):
          return lang.serverForgotPasswordFailure;
        default:
          return lang.serverForgotPasswordFailure;
      }
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: theme.scaffoldBackgroundColor,
          child: SingleChildScrollView(
            child: Stack(
              children: [
                Positioned(
                  top: 10.h,
                  left: 5.w,
                  child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: theme.colorScheme.secondary,
                      )),
                ),
                SizedBox(
                  height: 690.h,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 200.h,
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            offset: const Offset(0, 0),
                            color: theme.colorScheme.secondaryContainer,
                            spreadRadius: 10.h,
                            blurRadius: 300,
                          )
                        ]),
                      ),
                    ],
                  ),
                ),
                Positioned(
                    top: 5.h, right: 5.w, child: const MultiLanguageChanger()),
                BlocBuilder<AuthCubit, AuthState>(
                  builder: (context, state) {
                    return Container(
                      height: 600.h,
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                      ),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            heightSize(100),
                            Container(
                              width: double.infinity,
                              height: 80.h,
                              alignment: Alignment.centerLeft,
                              child: FittedBox(
                                child: Text(
                                  '${lang.loginToYour}\n${lang.account}',
                                  style: TextStyles.blackW900(context)
                                      .copyWith(fontSize: 35.sp),
                                ),
                              ),
                            ),
                            heightSize(50),
                            Text(
                              lang.resetPasswordInformation,
                              textAlign: TextAlign.center,
                              style: TextStyles.blackW400(context)
                                  .copyWith(fontSize: 12.sp),
                            ),
                            heightSize(10),
                            if (state is ErrorForgotPasswordState)
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  getFailureMessage(state.failure),
                                  style: TextStyles.redW600(context)
                                      .copyWith(fontSize: 12.sp),
                                ),
                              )
                            else
                              const SizedBox(),
                            heightSize(10),
                            StatefulBuilder(
                              builder:
                                  (BuildContext context, setStateController) {
                                return Column(
                                  children: [
                                    MyTextField(
                                        onChanged: (value) {
                                          setStateController(() {});
                                        },
                                        textInputAction: TextInputAction.next,
                                        icon: const Icon(Icons.mail_rounded),
                                        controller: emailController,
                                        title: lang.email),
                                    heightSize(40),
                                    GestureDetector(
                                      onTap: () {
                                        BlocProvider.of<AuthCubit>(context)
                                            .forgotPassword(
                                                email: emailController.text
                                                    .trim());
                                      },
                                      child: AuthButtonText(
                                          color: emailController.text.isEmpty
                                              ? theme.colorScheme.onSecondary
                                              : theme.colorScheme.secondary,
                                          text: Text(
                                            lang.sendResetEmail,
                                            style: TextStyles.whiteW500(context)
                                                .copyWith(
                                                    fontWeight:
                                                        FontWeight.w900),
                                          )),
                                    )
                                  ],
                                );
                              },
                            ),
                          ]),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
