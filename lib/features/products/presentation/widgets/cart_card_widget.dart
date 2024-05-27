import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_cubit/Auth_cubit.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/cart_cubit.dart/cubit/cart_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartCard extends StatelessWidget {
  final Checkout checkout;
  const CartCard({super.key, required this.checkout});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = context.themes();
    final lang = context.lang();
    return Container(
      width: double.infinity,
      height: 200.h,
      margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration: BoxDecoration(
          color: theme.colorScheme.background,
          borderRadius: BorderRadius.circular(30)),
      child: Row(
        children: [
          Container(
            width: 100.w,
            height: 200.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(25),
              child: Container(
                color: Colors.white,
                child: Image.network(
                  checkout.image,
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
          ),
          widthSize(20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Container(
                      width: 150.w,
                      height: 50.h,
                      child: FittedBox(
                        child: Text(
                          checkout.title,
                          style: TextStyles.blackW900(context)
                              .copyWith(fontSize: 18.sp),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      )),
                  widthSize(10),
                  GestureDetector(
                    onTap: () {
                      Account account =
                          BlocProvider.of<AuthCubit>(context).account!;
                      BlocProvider.of<CartCubit>(context)
                          .deleteCheckout(account: account, checkout: checkout);
                    },
                    child: Container(
                      width: 30.w,
                      height: 40.h,
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                        size: 20.sp,
                      ),
                    ),
                  )
                ],
              ),
              checkout.color == null
                  ? SizedBox()
                  : Row(
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          child: FittedBox(
                            child: Text(
                              lang.color + " :",
                              style: TextStyles.blackW600(context)
                                  .copyWith(fontSize: 20.sp),
                            ),
                          ),
                        ),
                        widthSize(5),
                        Container(
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(int.parse(
                                  checkout.color!.replaceAll('#', '0xff')))),
                        )
                      ],
                    ),
              checkout.size == null
                  ? SizedBox()
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          height: 40.h,
                          width: 40.w,
                          child: FittedBox(
                            child: Text(
                              lang.size + " :",
                              style: TextStyles.blackW600(context)
                                  .copyWith(fontSize: 20.sp),
                            ),
                          ),
                        ),
                        widthSize(5),
                        Container(
                          alignment: Alignment.center,
                          width: 30.w,
                          height: 30.h,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2, color: theme.colorScheme.secondary),
                              color: theme.colorScheme.primary),
                          child: FittedBox(
                            child: Text(
                              checkout.size!,
                              style: TextStyles.blackW500(context).copyWith(),
                            ),
                          ),
                        ),
                      ],
                    ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "\$${checkout.price.toStringAsFixed(2)}",
                      style: TextStyles.blackW500(context)
                          .copyWith(fontSize: 15.sp),
                    ),
                  ),
                  SizedBox(
                    width: 100.w,
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: theme.colorScheme.onBackground,
                    ),
                    child: FittedBox(
                      child: Text(
                        checkout.quantity.toString(),
                        style: TextStyles.blackW400(context).copyWith(),
                      ),
                    ),
                  )
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
