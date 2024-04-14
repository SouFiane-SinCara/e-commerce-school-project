import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatefulWidget {
  final void Function(String)? onChanged;
  final String title;
  final bool? obscureText;
  final bool? enableSuffixIcon;
  final Icon? suffixIcon;
  final Icon? secondSuffixIcon;
  final Icon icon;
  final TextEditingController controller;

  final TextInputAction textInputAction;

  const MyTextField(
      {super.key,
      required this.onChanged,
      required this.textInputAction,
      required this.icon,
      required this.controller,
      required this.title,
      this.suffixIcon,
      this.secondSuffixIcon,
      this.obscureText,
      this.enableSuffixIcon});

  @override
  State<MyTextField> createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool hideContent = true;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: TextField(
        onChanged: widget.onChanged,
        textInputAction: widget.textInputAction,
        obscureText: widget.obscureText != null && hideContent == true,
        style: TextStyle(
            color: theme.brightness == Brightness.dark
                ? const Color(0XFFffffff)
                : const Color(0XFF212121),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          fillColor: theme.colorScheme.primaryContainer,
          filled: true,
          contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 2.w),
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: theme.colorScheme.primaryContainer,
            ),
            borderRadius: const BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 2,
              color: theme.colorScheme.secondary,
            ),
          ),
          prefixIconColor: widget.controller.text.trim().isNotEmpty
              ? theme.brightness == Brightness.dark
                  ? const Color(0XFFffffff)
                  : const Color(0XFF212121)
              : theme.brightness == Brightness.dark
                  ? const Color(0XFF9e9e9e)
                  : const Color(0XFF9e9e9e),
          suffixIconColor: widget.controller.text.trim().isNotEmpty
              ? theme.brightness == Brightness.dark
                  ? const Color(0XFFffffff)
                  : const Color(0XFF212121)
              : theme.brightness == Brightness.dark
                  ? const Color(0XFF9e9e9e)
                  : const Color(0XFF9e9e9e),
          hintText: widget.title,
          hintStyle: TextStyles.blackW400(context),
          border: InputBorder.none,
          suffixIcon: widget.enableSuffixIcon == null
              ? null
              : widget.secondSuffixIcon != null
                  ? InkWell(
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onTap: () {
                        hideContent = !hideContent;
                        setState(() {});
                      },
                      child: hideContent == true
                          ? widget.suffixIcon
                          : widget.secondSuffixIcon)
                  : widget.suffixIcon,
          prefixIcon: widget.icon,
        ),
        cursorColor: theme.colorScheme.secondary,
      ),
    );
  }
}
