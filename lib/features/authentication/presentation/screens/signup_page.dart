import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignupPage extends StatefulWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  void initState() {
    super.initState();
    widget.emailController.addListener(_updateState);
    widget.passwordController.addListener(_updateState);
    widget.fullNameController.addListener(_updateState);
  }

  @override
  void dispose() {
    widget.emailController.removeListener(_updateState);
    widget.passwordController.removeListener(_updateState);
    widget.fullNameController.removeListener(_updateState);
    super.dispose();
  }

  void _updateState() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Size size = MediaQuery.of(context).size;
    widget.emailController.addListener(_updateState);
    widget.passwordController.addListener(_updateState);
    widget.fullNameController.addListener(_updateState);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: theme.colorScheme.secondary,
              )),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SingleChildScrollView(
          physics: const ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: size.width * 0.7,
                  height: size.height * 0.15,
                  margin: EdgeInsets.only(left: size.width * 0.05),
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                      child: Text(
                    "Create your \nAccount",
                    textAlign: TextAlign.left,
                    style:
                        theme.textTheme.displayLarge!.copyWith(fontSize: 15.sp),
                  )),
                ),
                heightSize(
                  0.06,
                ),
                MyTextField(
                    keyword: 'signupUser',
                    controller: widget.fullNameController,
                    icon: const Icon(
                      Icons.person_rounded,
                    ),
                    title: "Full Name"),
                heightSize(
                  0.03,
                ),
                //TODO: add multi languages ,
                MyTextField(
                    keyword: "signupEmail",
                    controller: widget.emailController,
                    icon: const Icon(
                      Icons.mail_rounded,
                    ),
                    title: "Email"),
                heightSize(
                  0.03,
                ),
                MyTextField(
                    keyword: "signupPassword",
                    controller: widget.passwordController,
                    obscureText: true,
                    suffixIcon: const Icon(Icons.visibility_off_rounded),
                    secondSuffixIcon: const Icon(Icons.visibility_rounded),
                    enableSuffixIcon: true,
                    icon: const Icon(
                      Icons.lock_rounded,
                    ),
                    title: "Password"),
                heightSize(
                  0.04,
                ),
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    debugPrint("hello");
                    debugPrint(widget.emailController.text);
                    debugPrint(widget.passwordController.text);
                  },
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(size.height),
                            right: Radius.circular(size.height)),
                        color: widget.emailController.text.trim().isEmpty ||
                                widget.fullNameController.text.trim().isEmpty ||
                                widget.passwordController.text.trim().isEmpty
                            ? const Color(0xFF393939)
                            : theme.colorScheme.secondary),
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: size.width * 0.05),
                    height: size.height * 0.07,
                    child: FittedBox(
                      child: Text("Sign up",
                          style: theme.textTheme.bodyMedium!.copyWith(
                            color: widget.emailController.text.trim().isEmpty ||
                                    widget.passwordController.text
                                        .trim()
                                        .isEmpty
                                ? Colors.white
                                : theme.colorScheme.primary,
                          )),
                    ),
                  ),
                ),
                heightSize(
                  0.03,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.03,
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.15),
                  alignment: Alignment.center,
                  child: FittedBox(
                      child: Text(
                    "Forgot the password?",
                    style: theme.textTheme.bodyMedium,
                  )),
                ),
                heightSize(
                  0.06,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 0.8,
                      color: theme.colorScheme.secondary.withOpacity(0.5),
                      margin: EdgeInsets.only(left: size.width * 0.1),
                      width: size.width * 0.2,
                    ),
                    Container(
                      width: size.width * 0.35,
                      height: size.height * 0.03,
                      alignment: Alignment.center,
                      child: FittedBox(
                          child: Text(
                        "or continue with",
                        style: theme.textTheme.bodyMedium!.copyWith(
                            color: theme.textTheme.bodyMedium!.color!
                                .withOpacity(0.7)),
                      )),
                    ),
                    Container(
                      height: 0.8,
                      margin: EdgeInsets.only(right: size.width * 0.1),
                      width: size.width * 0.2,
                      color: theme.colorScheme.secondary.withOpacity(0.5),
                    ),
                  ],
                ),
                heightSize(
                  0.04,
                ),
                Container(
                  width: size.width,
                  height: size.height * 0.06,
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                  decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      border: Border.all(
                          width: 2, color: theme.colorScheme.secondary),
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(size.height),
                          right: Radius.circular(size.height))),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.15,
                        height: size.height * 0.04,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(size.height),
                                topLeft: Radius.circular(size.height))),
                        child: Image.asset(
                            "lib/core/assets/images/google_logo.webp"),
                      ),
                      widthSize(0.01,),
                      Container(
                        width: size.width * 0.4,
                        height: size.height * 0.04,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(size.height),
                              bottomRight: Radius.circular(size.height)),
                        ),
                        child: FittedBox(
                          child: Text(
                            "Sign in with Google",
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                heightSize(0.03),
                Container(
                  width: size.width,
                  height: size.height * 0.02,
                  margin: EdgeInsets.symmetric(horizontal: size.width * 0.2),
                  child: FittedBox(
                    child: Row(
                      children: [
                        Text("Already have an account ?  ",
                            style: TextStyle(
                                color: theme.colorScheme.secondary,
                                fontWeight: FontWeight.w100,
                                fontFamily: 'Cabin')),
                        InkWell(
                          splashColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text("Sign in",
                              style: theme.textTheme.bodyMedium!
                                  .copyWith(fontWeight: FontWeight.w900)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
