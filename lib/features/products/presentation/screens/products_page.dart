import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/my_sizedbox.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_cubit/Auth_cubit.dart';
import 'package:e_commerce_school_project/features/products/domain/use_cases/product.dart';
import 'package:e_commerce_school_project/features/products/presentation/widgets/product_card_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:path/path.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.themes();

    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: 9 / 11,
                  crossAxisCount:
                      MediaQuery.of(context).size.width > 370 ? 2 : 1,
                ),
                itemCount: 50,
                itemBuilder: (BuildContext context, int index) {
                  return const ProductCard(
                    product: Product(
                      colors: [],
                      sizes: [],
                      title: "my Title",
                      rate: 4.55555555,
                      image:
                          "https://dfstudio-d420.kxcdn.com/wordpress/wp-content/uploads/2019/06/digital_camera_photo-1080x675.jpg",
                      price: 99.9999999,
                      description: "description",
                      category: "category",
                      stock: 199,
                      isFavorite: false,
                      isCart: false,
                    ),
                  );
                },
              ),
            ),
            Positioned(
              bottom: 15.h,
              child: Container(
                width: 355.w,
                height: 80.h,
                padding: EdgeInsets.only(
                  left: 70.w,
                  right: 70.w,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: GNav(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(15),
                      vertical: ScreenUtil().setHeight(15),
                    ),
                    tabMargin:
                        EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
                    mainAxisAlignment: MainAxisAlignment.center,
                    backgroundColor: theme.colorScheme.secondary,
                    color: theme.colorScheme.primary,
                    activeColor: theme.colorScheme.secondary,
                    hoverColor: Colors.transparent,
                    tabBackgroundColor: theme.colorScheme.primary,
                    duration: Duration(milliseconds: 500),
                    tabBorderRadius: 15,
                    iconSize: ScreenUtil().setSp(25),
                    tabs: [
                      GButton(
                        icon: Icons.home_rounded,
                      ),
                      GButton(
                        icon: Icons.shopping_cart_rounded,
                      ),
                      GButton(
                        icon: Icons.favorite_rounded,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
