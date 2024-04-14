import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/core/widgets/multi_language_changer.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/widgets/auth_button_text.dart';
import 'package:e_commerce_school_project/core/widgets/my_text_field.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/widgets/auth_google_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController fullNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    AppLocalizations? lang = AppLocalizations.of(context);
    ThemeData theme = context.themes();

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
                        heightSize(20),
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
                              '${lang!.createYour}\n${lang.account}',
                              style: TextStyles.blackW900(context)
                                  .copyWith(fontSize: 35.sp),
                            ),
                          ),
                        ),
                        heightSize(40),
                        FieldAndButtonSignUp(
                            fullNameController: fullNameController,
                            lang: lang,
                            emailController: emailController,
                            passwordController: passwordController,
                            theme: theme),

                        heightSize(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          margin: EdgeInsets.symmetric(horizontal: 80.w),
                          child: FittedBox(
                              child: RichText(
                            text: TextSpan(children: [
                              TextSpan(
                                  text: '${lang.alreadyHaveAnAccount}? ',
                                  style: TextStyles.greyW500(context)
                                      .copyWith(fontSize: 4.sp)),
                              TextSpan(
                                  text: lang.login,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.pop(context);
                                    },
                                  style: TextStyles.blackW900WithShadow(context)
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
    );
  }
}

class FieldAndButtonSignUp extends StatefulWidget {
  const FieldAndButtonSignUp({
    super.key,
    required this.fullNameController,
    required this.lang,
    required this.emailController,
    required this.passwordController,
    required this.theme,
  });

  final TextEditingController fullNameController;
  final AppLocalizations? lang;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final ThemeData theme;

  @override
  State<FieldAndButtonSignUp> createState() => _FieldAndButtonSignUpState();
}

class _FieldAndButtonSignUpState extends State<FieldAndButtonSignUp> {
  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    return Column(
      children: [
        MyTextField(
            onChanged: (value) {
              widget.fullNameController.text = value;
              setState(() {});
            },
            textInputAction: TextInputAction.next,
            icon: const Icon(Icons.person_rounded),
            controller: widget.fullNameController,
            title: lang.fullname),
        heightSize(20),
        MyTextField(
            onChanged: (value) {
              widget.emailController.text = value;
              setState(() {});
            },
            textInputAction: TextInputAction.next,
            icon: const Icon(Icons.mail_rounded),
            controller: widget.emailController,
            title: lang.email),
        heightSize(20),
        MyTextField(
            onChanged: (value) {
              widget.passwordController.text = value;
              setState(() {});
            },
            textInputAction: TextInputAction.done,
            icon: const Icon(Icons.lock_rounded),
            controller: widget.passwordController,
            enableSuffixIcon: true,
            suffixIcon: const Icon(Icons.visibility_rounded),
            obscureText: true,
            secondSuffixIcon: const Icon(Icons.visibility_off_rounded),
            title: lang.password),
        heightSize(40),
        AuthButtonText(
          text: Text(
            context.lang().signup,
            style: widget.emailController.text.trim().isNotEmpty &&
                    widget.fullNameController.text.trim().isNotEmpty &&
                    widget.passwordController.text.trim().isNotEmpty
                ? TextStyles.whiteW500(context).copyWith(
                    fontSize: 15.sp,
                  )
                : TextStyles.whiteW500(context)
                    .copyWith(fontSize: 15.sp, color: Colors.white),
          ),
          color: widget.emailController.text.trim().isNotEmpty &&
                  widget.fullNameController.text.trim().isNotEmpty &&
                  widget.passwordController.text.trim().isNotEmpty
              ? widget.theme.colorScheme.secondary
              : widget.theme.colorScheme.onSecondary,
        ),
      ],
    );
  }
}