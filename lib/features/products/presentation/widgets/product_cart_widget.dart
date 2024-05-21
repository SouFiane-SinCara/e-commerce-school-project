import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_cubit/Auth_cubit.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/cubit/wish_list_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCart extends StatelessWidget {
  final Product product;
  final bool? isWishList;
  const ProductCart({super.key, required this.product, this.isWishList});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.themes();
    final lang = context.lang();
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.onBackground,
        borderRadius: BorderRadius.circular(30),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: 10.w,
        vertical: 4.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 9 / 7,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: theme.colorScheme.secondary,
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    bottom: 0,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
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
                  Positioned(
                    top: 5.h,
                    right: 5.w,
                    child: StatefulBuilder(
                      builder: (BuildContext context, setFavoriteState) {
                        return GestureDetector(
                            onTap: () {
                              Account account =
                                  BlocProvider.of<AuthCubit>(context).account!;
                              if (isWishList == null) {
                                setFavoriteState(
                                  () =>
                                      product.isFavorite = !product.isFavorite,
                                );

                                BlocProvider.of<WishListCubit>(context)
                                    .addToWishList(
                                        product: product, account: account);
                              } else {
                                setFavoriteState(
                                  () =>
                                      product.isFavorite = !product.isFavorite,
                                );

                                BlocProvider.of<WishListCubit>(context)
                                    .deleteFromWishList(
                                        product: product, account: account);
                              }
                            },
                            child: isWishList == null
                                ? Container(
                                    decoration: BoxDecoration(
                                      color: !product.isFavorite
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.secondary,
                                      border: Border.all(
                                          width: 2,
                                          color: theme.colorScheme.primary),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                        !product.isFavorite
                                            ? Icons.favorite_rounded
                                            : Icons.done_rounded,
                                        size: 20.sp,
                                        shadows: [
                                          Shadow(
                                            color: theme.colorScheme.primary,
                                            blurRadius: 5,
                                            offset: Offset(0, 0),
                                          ),
                                        ],
                                        color: !product.isFavorite
                                            ? theme.colorScheme.secondary
                                            : theme.colorScheme.primary),
                                  )
                                : Icon(
                                    Icons.delete,
                                    color: Colors.red,
                                  ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          AspectRatio(
            aspectRatio: 9 / 4,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      product.title,
                      style: TextStyles.blackW900(context).copyWith(
                        fontSize: 12.sp,
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${product.price.toStringAsFixed(2)} \$',
                        style: TextStyles.blackW900(context)
                            .copyWith(fontFamily: "", fontSize: 15.sp),
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
                              text: " ${lang.items}",
                              style: TextStyles.blackW600(context)
                                  .copyWith(fontSize: 11.sp),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
