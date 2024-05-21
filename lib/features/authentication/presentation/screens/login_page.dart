import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/core/routing/routes_name.dart';
import 'package:e_commerce_school_project/core/widgets/loading.dart';
import 'package:e_commerce_school_project/features/authentication/data/sources/auth_remote_data_source.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_controllers_cubit/Auth_controllers_cubit.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_cubit/Auth_cubit.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/screens/signup_page.dart';
import 'package:e_commerce_school_project/features/multi_language/presentation/widgets/multi_language_changer.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/widgets/auth_button_text.dart';
import 'package:e_commerce_school_project/core/widgets/my_text_field.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/widgets/auth_google_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    BlocProvider.of<AuthCubit>(context).getCachedAccount();
    super.initState();
  }

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    AppLocalizations? lang = AppLocalizations.of(context);
    ThemeData theme = context.themes();
    String failureToMessage(Failures failure) {
      print("il fail $failure");
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
          case const (NonInternetConnectionLoginFailure):
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
        if (state is LoginSuccessState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            RoutesNames.productsPageName,
            (Route<dynamic> route) => false,
          );
        }
      },
      builder: (context, authState) {
        return authState is AuthLoadingState
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
                                      color:
                                          theme.colorScheme.secondaryContainer,
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
                            child: Column(children: [
                              heightSize(
                                5.h,
                              ),
                              const Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [MultiLanguageChanger()],
                              ),
                              heightSize(80),
                              Container(
                                width: double.infinity,
                                height: 80.h,
                                alignment: Alignment.centerLeft,
                                child: FittedBox(
                                  child: Text(
                                    '${lang!.loginToYour}\n${lang.account}',
                                    style: TextStyles.blackW900(context)
                                        .copyWith(fontSize: 35.sp),
                                  ),
                                ),
                              ),
                              heightSize(40),

                              authState is LoginErrorState
                                  ? Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        failureToMessage(authState.failure),
                                        style: TextStyles.redW600(context)
                                            .copyWith(fontSize: 12.sp),
                                      ),
                                    )
                                  : const SizedBox(),

                              heightSize(10),
                              MyTextField(
                                  onChanged: (value) {
                                    BlocProvider.of<AuthControllersCubit>(
                                            context)
                                        .updateLogin(email: value);
                                  },
                                  textInputAction: TextInputAction.next,
                                  icon: const Icon(Icons.mail_rounded),
                                  controller: emailController,
                                  title: lang.email),
                              heightSize(20),
                              MyTextField(
                                  onChanged: (value) {
                                    BlocProvider.of<AuthControllersCubit>(
                                            context)
                                        .updateLogin(password: value);
                                  },
                                  textInputAction: TextInputAction.done,
                                  icon: const Icon(Icons.lock_rounded),
                                  controller: passwordController,
                                  enableSuffixIcon: true,
                                  suffixIcon:
                                      const Icon(Icons.visibility_rounded),
                                  obscureText: true,
                                  secondSuffixIcon:
                                      const Icon(Icons.visibility_off_rounded),
                                  title: lang.password),
                              heightSize(40),
                              BlocBuilder<AuthControllersCubit,
                                  AuthControllersState>(
                                builder: (context, controllers) {
                                  return GestureDetector(
                                    onTap: () async {
                                      String email =
                                          BlocProvider.of<AuthControllersCubit>(
                                                  context)
                                              .emailLogin
                                              .trim();
                                      String password =
                                          BlocProvider.of<AuthControllersCubit>(
                                                  context)
                                              .passwordLogin;

                                      await context.read<AuthCubit>().login(
                                            email: email,
                                            password: password,
                                            context: context,
                                          );
                                    },
                                    child: AuthButtonText(
                                      text: Text(
                                        context.lang().login,
                                        style: controllers
                                                    is LoginControllersUpdateState &&
                                                controllers.email.isNotEmpty &&
                                                controllers.password.isNotEmpty
                                            ? TextStyles.whiteW500(context)
                                                .copyWith(
                                                fontSize: 15.sp,
                                              )
                                            : TextStyles.whiteW500(context)
                                                .copyWith(
                                                    fontSize: 15.sp,
                                                    color: Colors.white),
                                      ),
                                      color: controllers
                                                  is LoginControllersUpdateState &&
                                              controllers.email.isNotEmpty &&
                                              controllers.password.isNotEmpty
                                          ? theme.colorScheme.secondary
                                          : theme.colorScheme.onSecondary,
                                    ),
                                  );
                                },
                              ),

                              heightSize(20),

                              Container(
                                width: double.infinity,
                                height: 20.h,
                                margin: EdgeInsets.symmetric(horizontal: 80.w),
                                child: GestureDetector(
                                  onTap: () async {
                                    Navigator.pushNamed(context,
                                        RoutesNames.forgotPasswordPageName);
                                  },
                                  child: FittedBox(
                                    child: Text(
                                      '${lang.forgotthepassowrd} ?',
                                      style: TextStyles.blackW600WithShadow(
                                          context),
                                    ),
                                  ),
                                ),
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
                                  widthSize(10),
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
                                margin: EdgeInsets.symmetric(horizontal: 80.w),
                                child: FittedBox(
                                    child: RichText(
                                  text: TextSpan(children: [
                                    TextSpan(
                                        text: '${lang.donthaveanaccount}? ',
                                        style: TextStyles.greyW500(context)
                                            .copyWith(fontSize: 4.sp)),
                                    TextSpan(
                                        text: lang.signup,
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () async {
                                            await Navigator.pushNamed(context,
                                                RoutesNames.signUpPageName);
                                            print("call update login");
                                            BlocProvider.of<
                                                        AuthControllersCubit>(
                                                    context)
                                                .updateLogin();
                                          },
                                        style: TextStyles.blackW900WithShadow(
                                                context)
                                            .copyWith(fontSize: 4.sp)),
                                  ]),
                                )),
                              ),
                            ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
      },
    );
  }
}
