import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/core/routing/routes_name.dart';
import 'package:e_commerce_school_project/core/widgets/loading.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_controllers_cubit/Auth_controllers_cubit.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_cubit/Auth_cubit.dart';
import 'package:e_commerce_school_project/features/multi_language/presentation/widgets/multi_language_changer.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/widgets/auth_button_text.dart';
import 'package:e_commerce_school_project/core/widgets/my_text_field.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/widgets/auth_google_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    fullNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AppLocalizations? lang = AppLocalizations.of(context);
    ThemeData theme = context.themes();
    String failureToMessage(Failures failure) {
      AppLocalizations? lang = context.lang();
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
        case const (NonInternetConnectionSignUpFailure):
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

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        print("init login");
        if (state is SignUpSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.productsPageName,
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, state) => state is AuthLoadingState
          ? const Loading()
          : SafeArea(
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
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 20.w,
                          ),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                heightSize(15),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [MultiLanguageChanger()],
                                ),
                                heightSize(50),
                                Container(
                                  width: double.infinity,
                                  height: 80.h,
                                  alignment: Alignment.centerLeft,
                                  child: FittedBox(
                                    child: Text(
                                      '${lang!.createYour}\n${lang.account}',
                                      style: TextStyles.blackW900(context)
                                          .copyWith(fontSize: 35.sp),
                                    ),
                                  ),
                                ),
                                heightSize(40),

                                state is SignUpErrorState
                                    ? Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          failureToMessage(state.failure),
                                          style: TextStyles.redW600(context)
                                              .copyWith(fontSize: 12.sp),
                                        ),
                                      )
                                    : const SizedBox(),

                                heightSize(10),

                                StatefulBuilder(
                                  builder:
                                      (BuildContext context, setFieldsState) {
                                    return Column(
                                      children: [
                                        MyTextField(
                                            onChanged: (value) {
                                              setFieldsState(
                                                () => fullNameController,
                                              );
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            icon: const Icon(
                                                Icons.person_rounded),
                                            controller: fullNameController,
                                            title: lang.fullname),
                                        heightSize(20),
                                        MyTextField(
                                            onChanged: (value) {
                                              setFieldsState(
                                                () => emailController,
                                              );
                                            },
                                            textInputAction:
                                                TextInputAction.next,
                                            icon:
                                                const Icon(Icons.mail_rounded),
                                            controller: emailController,
                                            title: lang.email),
                                        heightSize(20),
                                        MyTextField(
                                            onChanged: (value) {
                                              setFieldsState(
                                                () => passwordController,
                                              );
                                            },
                                            textInputAction:
                                                TextInputAction.done,
                                            icon:
                                                const Icon(Icons.lock_rounded),
                                            controller: passwordController,
                                            enableSuffixIcon: true,
                                            suffixIcon: const Icon(
                                                Icons.visibility_rounded),
                                            obscureText: true,
                                            secondSuffixIcon: const Icon(
                                                Icons.visibility_off_rounded),
                                            title: lang.password),
                                        heightSize(40),
                                        GestureDetector(
                                          onTap: () async {
                                            BlocProvider.of<AuthCubit>(context)
                                                .signUp(
                                              emailController.text.trim(),
                                              fullNameController.text.trim(),
                                              passwordController.text,
                                            );
                                          },
                                          child: AuthButtonText(
                                            text: Text(
                                              context.lang().signup,
                                              style: fullNameController.text
                                                          .trim()
                                                          .isNotEmpty &&
                                                      passwordController
                                                          .text.isNotEmpty &&
                                                      emailController.text
                                                          .trim()
                                                          .isNotEmpty
                                                  ? TextStyles.whiteW500(
                                                          context)
                                                      .copyWith(
                                                      fontSize: 15.sp,
                                                    )
                                                  : TextStyles.whiteW500(
                                                          context)
                                                      .copyWith(
                                                          fontSize: 15.sp,
                                                          color: Colors.white),
                                            ),
                                            color: fullNameController.text
                                                        .trim()
                                                        .isNotEmpty &&
                                                    passwordController
                                                        .text.isNotEmpty &&
                                                    emailController.text
                                                        .trim()
                                                        .isNotEmpty
                                                ? theme.colorScheme.secondary
                                                : theme.colorScheme.onSecondary,
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                heightSize(20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    widthSize(20),
                                    Expanded(
                                      child: Divider(
                                        color: theme.colorScheme.onSecondary
                                            .withOpacity(0.5),
                                        height: 5.h,
                                      ),
                                    ),
                                    widthSize(20),
                                    Text(
                                      lang.orcontinuewith,
                                      style: TextStyles.blackW500(context),
                                    ),
                                    widthSize(10),
                                    Expanded(
                                      child: Divider(
                                        color: theme.colorScheme.onSecondary
                                            .withOpacity(0.5),
                                        height: 5.h,
                                      ),
                                    ),
                                    widthSize(20),
                                  ],
                                ),

                                heightSize(20),
                                const AuthWithGoogleButton(),
                                heightSize(20),

                                //? -----------------------don't have an account sign up---------------------------
                                Container(
                                  width: double.infinity,
                                  height: 20.h,
                                  margin:
                                      EdgeInsets.symmetric(horizontal: 80.w),
                                  child: FittedBox(
                                      child: RichText(
                                    text: TextSpan(children: [
                                      TextSpan(
                                          text:
                                              '${lang.alreadyHaveAnAccount}? ',
                                          style: TextStyles.greyW500(context)
                                              .copyWith(fontSize: 4.sp)),
                                      TextSpan(
                                          text: lang.login,
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              Navigator.pop(context);
                                            },
                                          style: TextStyles.blackW900WithShadow(
                                                  context)
                                              .copyWith(fontSize: 4.sp)),
                                    ]),
                                  )),
                                ),
                                heightSize(20)
                              ]),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}
