import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/features/products/domain/use_cases/product.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.themes();
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 9 / 7,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: theme.colorScheme.onBackground,
              ),
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Center(
                    child: CircularProgressIndicator(
                      color: theme.colorScheme.secondary,
                    ),
                  );
                },
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 9 / 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.title,
                      style: TextStyles.blackW900(context).copyWith(
                        fontSize: 15.sp,
                      ),
                      maxLines: 1,
                    ),
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.star_half_rounded,
                        color: theme.colorScheme.secondary,
                        size: 19.sp,
                      ),
                      widthSize(2),
                      Text(
                        product.rate.toStringAsFixed(1).toString(),
                        style: TextStyles.greyW600(context)
                            .copyWith(fontSize: 13.sp, fontFamily: ""),
                      ),
                      widthSize(15),
                      Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.onBackground,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: product.stock.toString(),
                              style: TextStyles.blackW500(context)
                                  .copyWith(fontFamily: "", fontSize: 11.sp),
                            ),
                            TextSpan(
                              text: " stock",
                              style: TextStyles.blackW600(context)
                                  .copyWith(fontSize: 11.sp),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                  heightSize(2.h),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${product.price.toStringAsFixed(2)} \$',
                      style: TextStyles.blackW900(context)
                          .copyWith(fontFamily: "", fontSize: 15.sp),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
