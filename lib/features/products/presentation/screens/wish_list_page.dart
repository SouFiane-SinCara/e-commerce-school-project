import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/core/widgets/loading.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/cubit/wish_list_cubit.dart';
import 'package:e_commerce_school_project/features/products/presentation/widgets/product_cart_widget.dart';
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
          return state is! UpdateWishListState
              ? Loading()
              : state.wishList.isEmpty
                  ? Center(
                      child: Text(
                        lang.yourWishlistIsEmpty,
                        style: TextStyles.blackW900(context).copyWith(
                          fontSize: 20.sp,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: state.wishList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          margin: EdgeInsets.symmetric(vertical: 50.h),
                          child: ProductCart(
                            isWishList: true,
                            product: state.wishList[index],
                          ),
                        );
                      },
                    );
        },
      ),
    );
  }
}
