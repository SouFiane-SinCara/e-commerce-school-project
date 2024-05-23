import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_cubit/Auth_cubit.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/cart_cubit.dart/cubit/cart_cubit.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/wish_list_cubit/wish_list_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsProductsPage extends StatelessWidget {
  final Product product;
  const DetailsProductsPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.themes();
    final lang = context.lang();
    void showAddToCartDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: theme.colorScheme.primary,
            title: Text(
              context.lang().itemAddedToCartSuccessfully,
              style: TextStyles.blackW600(context).copyWith(fontSize: 15.sp),
              textAlign: TextAlign.center,
            ),
            content: Icon(
              Icons.check_circle_outline_sharp,
              color: theme.colorScheme.secondary,
              size: 80.sp,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'OK',
                  style:
                      TextStyles.blackW600(context).copyWith(fontSize: 15.sp),
                ),
              ),
            ],
          );
        },
      );
    }

    bool readMore = false;
    Color? selectedColor = product.colors.isEmpty
        ? null
        : Color(int.parse(product.colors.first.replaceAll('#', '0xff')));
    String? selectedSize = product.sizes.isEmpty ? null : product.sizes.first;
    int quantity = 1;
    return SafeArea(
        child: Scaffold(
      backgroundColor: theme.colorScheme.primary,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: 350.h,
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
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.symmetric(horizontal: 10.w),
              child: Column(
                children: [
                  heightSize(10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FittedBox(
                        child: Container(
                          width: 300.w,
                          child: Text(
                            product.title,
                            style: TextStyles.blackW900(context)
                                .copyWith(fontSize: 20.sp),
                          ),
                        ),
                      ),
                      StatefulBuilder(
                        builder: (BuildContext context, setFavoriteState) {
                          return GestureDetector(
                            onTap: () {
                              Account account =
                                  BlocProvider.of<AuthCubit>(context).account!;
                              if (product.isFavorite == false) {
                                setFavoriteState(
                                  () =>
                                      product.isFavorite = !product.isFavorite!,
                                );

                                BlocProvider.of<WishListCubit>(context)
                                    .addToWishList(
                                        product: product, account: account);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: !product.isFavorite!
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.secondary,
                                border: Border.all(
                                    width: 2, color: theme.colorScheme.primary),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                  !product.isFavorite!
                                      ? Icons.favorite_rounded
                                      : Icons.done_rounded,
                                  size: 25.sp,
                                  shadows: [
                                    Shadow(
                                      color: theme.colorScheme.primary,
                                      blurRadius: 5,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                  color: !product.isFavorite!
                                      ? theme.colorScheme.secondary
                                      : theme.colorScheme.primary),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                  heightSize(10),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      alignment: Alignment.center,
                      width: 80.w,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.onBackground,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: product.stock.toString(),
                            style: TextStyles.blackW500(context)
                                .copyWith(fontFamily: "", fontSize: 15.sp),
                          ),
                          TextSpan(
                            text: " ${lang.items}",
                            style: TextStyles.blackW600(context)
                                .copyWith(fontSize: 15.sp),
                          ),
                        ]),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Divider(
              color: theme.colorScheme.secondary,
              indent: 10.w,
              endIndent: 10.w,
              height: 40.h,
              thickness: 0.4,
            ),
            StatefulBuilder(
              builder: (BuildContext context, setReadMoreState) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Text(
                        product.description,
                        style: TextStyles.blackW500(context)
                            .copyWith(fontSize: 12.sp),
                        maxLines: readMore ? null : 2,
                        textAlign: TextAlign.center,
                        overflow: readMore
                            ? TextOverflow.visible
                            : TextOverflow.ellipsis,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setReadMoreState(
                          () => readMore = !readMore,
                        );
                      },
                      child: Text(
                        readMore == true ? lang.less : lang.more,
                        style: TextStyles.blackW600(context)
                            .copyWith(fontSize: 14.sp, color: Colors.blue[600]),
                      ),
                    ),
                  ],
                );
              },
            ),
            heightSize(20),
            product.colors.isEmpty
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      lang.colors + " :",
                      style: TextStyles.blackW600(context)
                          .copyWith(fontSize: 17.sp),
                    ),
                  ),
            product.colors.isEmpty ? SizedBox() : heightSize(15),
            product.colors.isEmpty
                ? SizedBox()
                : StatefulBuilder(
                    builder: (context, setSelectedColorState) => Container(
                      height: 40.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ListView.builder(
                        itemCount: product.colors.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setSelectedColorState(() {
                                selectedColor = Color(int.parse(product
                                    .colors[index]
                                    .replaceAll('#', '0xff')));
                              });
                            },
                            child: selectedColor != null &&
                                    Color(int.parse(product.colors[index]
                                            .replaceAll('#', '0xff'))) ==
                                        selectedColor
                                ? Stack(
                                    children: [
                                      Container(
                                        width: 40.w,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 4,
                                                color:
                                                    theme.colorScheme.primary),
                                            shape: BoxShape.circle,
                                            color: Color(int.parse(product
                                                .colors[index]
                                                .replaceAll('#', '0xff')))),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        bottom: 0,
                                        left: 0,
                                        child: Icon(
                                          Icons.done,
                                          color: theme.colorScheme.secondary,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(
                                    width: 40.w,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(int.parse(product
                                            .colors[index]
                                            .replaceAll('#', '0xff')))),
                                  ),
                          );
                        },
                      ),
                    ),
                  ),
            heightSize(10),
            product.sizes.isEmpty
                ? SizedBox()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      lang.sizes + " :",
                      style: TextStyles.blackW600(context)
                          .copyWith(fontSize: 17.sp),
                    )),
            heightSize(10.h),
            product.sizes.isEmpty
                ? SizedBox()
                : StatefulBuilder(
                    builder: (context, setSelectedSizeState) => Container(
                      height: 40.h,
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: ListView.builder(
                        itemCount: product.sizes.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () {
                              setSelectedSizeState(() {
                                selectedSize = product.sizes[index];
                              });
                            },
                            child: Container(
                              width: 40.w,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                      width: 2,
                                      color: theme.colorScheme.secondary),
                                  color: selectedSize != null &&
                                          selectedSize == product.sizes[index]
                                      ? theme.colorScheme.secondary
                                      : theme.colorScheme.primary),
                              child: Text(
                                product.sizes[index],
                                style: selectedSize != null &&
                                        selectedSize == product.sizes[index]
                                    ? TextStyles.whiteW500(context)
                                        .copyWith(fontSize: 15.sp)
                                    : TextStyles.blackW500(context)
                                        .copyWith(fontSize: 15.sp),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
            heightSize(20.h),
            StatefulBuilder(
              builder: (BuildContext context, setQuantityState) {
                return Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        children: [
                          Text(
                            lang.quantity,
                            style: TextStyles.blackW600(context)
                                .copyWith(fontSize: 17.sp),
                          ),
                          widthSize(20),
                          Container(
                              width: 100.w,
                              height: 40.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: theme.colorScheme.onBackground,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        if (quantity > 1) {
                                          setQuantityState(() => quantity--);
                                        }
                                      },
                                      child: Container(
                                        width: 20.w,
                                        alignment: Alignment.topCenter,
                                        child: Text(
                                          "-",
                                          style: TextStyles.blackW600(context)
                                              .copyWith(fontSize: 25.sp),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      "$quantity",
                                      style: TextStyles.blackW600(context)
                                          .copyWith(fontSize: 18.sp),
                                    ),
                                    Container(
                                      alignment: Alignment.center,
                                      child: GestureDetector(
                                        onTap: () {
                                          if (quantity < product.stock) {
                                            setQuantityState(() => quantity++);
                                          }
                                        },
                                        child: Icon(
                                          Icons.add,
                                          color: theme.colorScheme.secondary,
                                          size: 20.sp,
                                        ),
                                      ),
                                    ),
                                  ]))
                        ],
                      ),
                    ),
                    heightSize(20.h),
                    Divider(
                      endIndent: 10.w,
                      indent: 10.w,
                      thickness: 0.1,
                      color: theme.colorScheme.secondary,
                    ),
                    heightSize(20.h),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                lang.totalePrice,
                                style: TextStyles.blackW400(context)
                                    .copyWith(fontSize: 13.sp),
                              ),
                              heightSize(5.h),
                              FittedBox(
                                child: Container(
                                  width: 150.w,
                                  height: 40.h,
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "\$" +
                                        (product.price * quantity)
                                            .toStringAsFixed(2),
                                    style: TextStyles.blackW900(context)
                                        .copyWith(fontSize: 30.sp),
                                    maxLines: 1,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          StatefulBuilder(
                              builder: (context, setAddToCardColorState) {
                            return GestureDetector(
                              onTap: () async {
                                String colorToHex(Color color) {
                                  String hexColor = color.value
                                      .toRadixString(16)
                                      .padLeft(8, '0');

                                  return '#${hexColor.substring(0, 2)}${hexColor.substring(2, 8)}';
                                }

                                Account account =
                                    BlocProvider.of<AuthCubit>(context)
                                        .account!;
                                await BlocProvider.of<CartCubit>(context)
                                    .addToCart(
                                        account: account,
                                        newCheckout: Checkout(
                                          productId: product.id,
                                          title: product.title,
                                          image: product.image,
                                          price: product.price * quantity,
                                          description: product.description,
                                          size: selectedSize,
                                          category: product.category,
                                          color: selectedColor == null
                                              ? null
                                              : colorToHex(selectedColor!),
                                          quantity: quantity,
                                          fullName: account.fullName,
                                          email: account.email,
                                        ));
                                showAddToCartDialog(context);
                              },
                              child: Container(
                                width: 180.w,
                                height: 50.h,
                                decoration: BoxDecoration(
                                    color: theme.colorScheme.secondary,
                                    borderRadius: BorderRadius.circular(30)),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_bag_rounded,
                                      color: theme.colorScheme.primary,
                                      size: 25.sp,
                                    ),
                                    widthSize(10),
                                    Text(
                                      lang.addToCart,
                                      style: TextStyles.whiteW900(context)
                                          .copyWith(fontSize: 15.sp),
                                    )
                                  ],
                                ),
                              ),
                            );
                          })
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            heightSize(20.h),
          ],
        ),
      ),
    ));
  }
}
