import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/features/authentication/logic/text_field_controllers_cubit/text_field_controllers_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyTextField extends StatefulWidget {
  final String title;
  final bool? obscureText;
  final bool? enableSuffixIcon;
  final Icon? suffixIcon;
  final Icon? secondSuffixIcon;
  final Icon icon;
  final TextEditingController controller;
  final String keyword;

  const MyTextField(
      {super.key,
      required this.icon,
      required this.keyword,
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
  int charactersLength = 0;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return TextField(
      onChanged: (value) {
        charactersLength = value.length;
        setState(() {});

        widget.controller.text = value;
        BlocProvider.of<TextFieldControllersCubit>(context)
            .updateController(widget.keyword, widget.controller);
      },
      obscureText: widget.obscureText != null && hideContent == true,
      style: TextStyle(
          color: theme.brightness == Brightness.dark
              ? const Color(0XFFffffff)
              : const Color(0XFF212121),
          fontWeight: FontWeight.bold),
      decoration: InputDecoration(
        fillColor: theme.colorScheme.primaryContainer,
        filled: true,
        contentPadding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 2.w),
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
        prefixIconColor: charactersLength != 0
            ? theme.brightness == Brightness.dark
                ? const Color(0XFFffffff)
                : const Color(0XFF212121)
            : theme.brightness == Brightness.dark
                ? const Color(0XFF9e9e9e)
                : const Color(0XFF9e9e9e),
        suffixIconColor: charactersLength != 0
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
    );
  }
}
