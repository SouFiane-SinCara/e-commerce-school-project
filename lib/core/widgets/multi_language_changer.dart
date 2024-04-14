import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiLanguageChanger extends StatelessWidget {
  const MultiLanguageChanger({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = context.lang();
    return GestureDetector(
      onTap: () {},
      child: Row(
        children: [
          Text(
            lang.language,
            style: TextStyles.blackW600WithShadow(context)
                .copyWith(fontSize: 10.sp),
          )
        ],
      ),
    );
  }
}
