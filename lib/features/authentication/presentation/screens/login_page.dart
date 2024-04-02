import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/widgets/auth_button_text.dart';
import 'package:e_commerce_school_project/core/widgets/my_text_field.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/widgets/auth_google_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();
  LoginPage({super.key});

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
                Container(
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
                            offset: Offset(0, 0),
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
                  child: Column(children: [
                    heightSize(120),
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
                    MyTextField(
                        keyword: "loginEmail",
                        icon: const Icon(Icons.mail_rounded),
                        controller: emailController,
                        title: lang.email),
                    heightSize(20),
                    MyTextField(
                        keyword: "loginPassword",
                        icon: const Icon(Icons.lock_rounded),
                        controller: passwordController,
                        enableSuffixIcon: true,
                        suffixIcon: const Icon(Icons.visibility_rounded),
                        obscureText: true,
                        secondSuffixIcon:
                            const Icon(Icons.visibility_off_rounded),
                        title: lang.password),
                    heightSize(40),
                    const AuthButtonText(),
                    heightSize(20),
                    Container(
                      width: double.infinity,
                      height: 20.h,
                      margin: EdgeInsets.symmetric(horizontal: 80.w),
                      child: FittedBox(
                        child: Text(
                          lang.forgotthepassowrd + ' ?',
                          style: TextStyles.blackW600WithShadow(context),
                        ),
                      ),
                    ),
                    heightSize(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        widthSize(20),
                        Expanded(
                          child: Divider(
                            color:
                                theme.colorScheme.onSecondary.withOpacity(0.5),
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
                            color:
                                theme.colorScheme.onSecondary.withOpacity(0.5),
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
                              text: lang.donthaveanaccount + '? ',
                              style: TextStyles.greyW500(context)
                                  .copyWith(fontSize: 4.sp)),
                          TextSpan(
                              text: lang.signup,
                              style: TextStyles.blackW900WithShadow(context)
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
  }
}
