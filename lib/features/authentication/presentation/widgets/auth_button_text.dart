import 'package:e_commerce_school_project/core/helper/extension.dart';

import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButtonText extends StatelessWidget {
  final Color color;
  final Text text;
  const AuthButtonText({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.themes();
    return Container(
      width: double.infinity,
      height: 50.h,
      decoration: BoxDecoration(
          //TODO : adjust dark theme
          boxShadow: [
            BoxShadow(
                color: theme.shadowColor,
                offset: Offset.fromDirection(4, -6),
                blurRadius: 4)
          ],
          color: color,
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(400.h), right: Radius.circular(400.h))),
      alignment: Alignment.center,
      child: FittedBox(child: text),
    );
  }
}
