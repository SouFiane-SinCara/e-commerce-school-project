import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/core/routing/routes_name.dart';
import 'package:e_commerce_school_project/core/widgets/loading.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/wish_list_cubit/wish_list_cubit.dart';
import 'package:e_commerce_school_project/features/products/presentation/widgets/product_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishListPage extends StatelessWidget {
  const WishListPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.themes();
    final lang = context.lang();

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.primary,
      child: BlocBuilder<WishListCubit, WishListState>(
        builder: (context, state) {
          if (state is! UpdateWishListState) {
            return Loading();
          } else if (state.wishList.isEmpty) {
            return Center(
              child: Text(
                lang.yourWishlistIsEmpty,
                style: TextStyles.blackW900(context).copyWith(
                  fontSize: 20.sp,
                ),
              ),
            );
          } else {
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.8,
                crossAxisSpacing: 10.w,
                mainAxisSpacing: 10.h,
              ),
              itemCount: state.wishList.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                        context, RoutesNames.detailsProductPageName,
                        arguments: state.wishList[index]);
                  },
                child: ProductCard(
                    isWishList: true,
                    product: state.wishList[index],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
