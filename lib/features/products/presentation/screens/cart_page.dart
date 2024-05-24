import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/core/routing/routes_name.dart';
import 'package:e_commerce_school_project/core/widgets/loading.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/cart_cubit.dart/cubit/cart_cubit.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/get_products_cubit/cubit/get_products_cubit.dart';
import 'package:e_commerce_school_project/features/products/presentation/screens/complete_checkout.dart';
import 'package:e_commerce_school_project/features/products/presentation/widgets/cart_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.themes();
    final lang = context.lang();
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.primary,
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is UpdateCartState) {
            state.checkouts = state.checkouts.reversed.toList();
            return ListView.builder(
              itemCount: state.checkouts.length + 1,
              itemBuilder: (BuildContext context, int index) {
                index == state.checkouts.length
                    ? null
                    : print(state.checkouts[index].color);
                double tot = 0;
                state.checkouts.forEach(
                  (element) {
                    tot += element.price;
                  },
                );
                if (state.checkouts.isEmpty) {
                  return Container(
                    width: double.infinity,
                    height: 630.h,
                    alignment: Alignment.center,
                    child: Text(
                      lang.yourCartIsEmpty,
                      style: TextStyles.blackW900(context).copyWith(
                        fontSize: 20.sp,
                      ),
                    ),
                  );
                } else {
                  return index == state.checkouts.length
                      ? Container(
                          height: 240.h,
                          width: double.infinity,
                          child: Column(
                            children: [
                              heightSize(10),
                              Divider(
                                color: theme.colorScheme.secondary,
                                indent: 20.w,
                                endIndent: 20.w,
                              ),
                              heightSize(10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lang.totalePrice,
                                        style: TextStyles.blackW400(context)
                                            .copyWith(fontSize: 13.sp),
                                      ),
                                      heightSize(5.h),
                                      Container(
                                        width: 150.w,
                                        height: 40.h,
                                        child: FittedBox(
                                          child: Text(
                                            "\$" + (tot).toStringAsFixed(2),
                                            style: TextStyles.blackW900(context)
                                                .copyWith(),
                                            maxLines: 1,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(context,
                                          RoutesNames.completeCheckoutName);
                                    },
                                    child: Container(
                                      width: 180.w,
                                      height: 50.h,
                                      decoration: BoxDecoration(
                                          color: theme.colorScheme.secondary,
                                          borderRadius:
                                              BorderRadius.circular(30)),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.shopping_bag_rounded,
                                            color: theme.colorScheme.primary,
                                            size: 25.sp,
                                          ),
                                          widthSize(10),
                                          Text(
                                            lang.checkout,
                                            style: TextStyles.whiteW900(context)
                                                .copyWith(fontSize: 15.sp),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              heightSize(80),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            List<Product> products =
                                BlocProvider.of<GetProductsCubit>(context)
                                    .products;
                            Product? product;
                            for (int i = 0; i < products.length; i++) {
                              if (products[i].id ==
                                  state.checkouts[index].productId) {
                                product = products[i];
                                break;
                              }
                            }
                            Navigator.pushNamed(
                                context, RoutesNames.detailsProductPageName,
                                arguments: product);
                          },
                          child: CartCard(
                            checkout: state.checkouts[index],
                          ),
                        );
                }
              },
            );
          } else {
            return const Loading();
          }
        },
      ),
    );
  }
}
