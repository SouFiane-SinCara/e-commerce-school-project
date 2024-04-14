import '../../../../core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:flutter/material.dart';
import '../../../../core/helper/my_sizedbox.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthWithGoogleButton extends StatelessWidget {
  const AuthWithGoogleButton({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.themes();
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 80.w),
      width: double.infinity,
      height: 30.h,
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
                color: theme.shadowColor,
                offset: Offset.fromDirection(4, -6),
                blurRadius: 12)
          ],
          color: theme.colorScheme.primary,
          border: Border.all(width: 2, color: theme.colorScheme.secondary),
          borderRadius: BorderRadius.horizontal(
              left: Radius.circular(200.h), right: Radius.circular(200.h))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            height: 25.h,
            width: 25.w,
            padding: EdgeInsets.symmetric(vertical: 3.h),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(100.h),
                    topLeft: Radius.circular(100.h))),
            child: Image.asset("lib/core/assets/images/google_logo.webp"),
          ),
          widthSize(
            0.03,
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 3.h),
            height: 25.h,
            width: 120.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(100.h),
                  bottomRight: Radius.circular(100.h)),
            ),
            child: FittedBox(
              child: Text(
                context.lang().signinwithgoogle,
                style: TextStyles.blackW600(context).copyWith(fontSize: 15.sp),
              ),
            ),
          )
        ],
      ),
    );
  }
}
