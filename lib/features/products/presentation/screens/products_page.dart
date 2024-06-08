import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/core/routing/routes_name.dart';
import 'package:e_commerce_school_project/core/widgets/loading.dart';
import 'package:e_commerce_school_project/core/widgets/my_text_field.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_cubit/Auth_cubit.dart';
import 'package:e_commerce_school_project/features/multi_language/presentation/widgets/multi_language_changer.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/cart_cubit.dart/cubit/cart_cubit.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/wish_list_cubit/wish_list_cubit.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/get_products_cubit/cubit/get_products_cubit.dart';
import 'package:e_commerce_school_project/features/products/presentation/screens/cart_page.dart';
import 'package:e_commerce_school_project/features/products/presentation/screens/wish_list_page.dart';
import 'package:e_commerce_school_project/features/products/presentation/widgets/product_card_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductsPage extends StatefulWidget {
  ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage>
    with AutomaticKeepAliveClientMixin {
  bool showTextField = false;
  late TextEditingController searchController;
  List<Product> filteredProducts = [];
  List<Product> allProducts = [];

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
    searchController.addListener(_onSearchChanged);
    _fetchData(context);
  }

  void _fetchData(BuildContext context) {
    Account account = BlocProvider.of<AuthCubit>(context).account!;
    BlocProvider.of<GetProductsCubit>(context).getProducts(account: account);
    BlocProvider.of<CartCubit>(context).addToCart(account: account);
    BlocProvider.of<CartCubit>(context).getCartList(account: account);
  }

  void _onSearchChanged() {
    setState(() {
      filteredProducts = allProducts
          .where((product) => product.title
              .toLowerCase()
              .contains(searchController.text.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(
        context); // Need to call super.build when using AutomaticKeepAliveClientMixin
    ThemeData theme = context.themes();

    Future<bool> showLogoutDialog(BuildContext context, String language) {
      String title, content, noButtonText, yesButtonText;
      if (language == 'en') {
        title = 'Logout';
        content = 'Are you sure you want to logout?';
        noButtonText = 'No';
        yesButtonText = 'Yes';
      } else {
        title = 'Disconnettersi';
        content = 'Sei sicuro di voler uscire?';
        noButtonText = 'No';
        yesButtonText = 'Sì';
      }
      print('rebuild');
      return showDialog<bool>(
        barrierColor: Colors.transparent,
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    title,
                    style:
                        TextStyles.whiteW900(context).copyWith(fontSize: 20.sp),
                  ),
                  SizedBox(height: 20),
                  Text(content,
                      style: TextStyles.whiteW500(context)
                          .copyWith(fontSize: 15.sp)),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: Text(noButtonText),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      TextButton(
                        child: Text(yesButtonText),
                        style: TextButton.styleFrom(
                          foregroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        onPressed: () async {
                          Navigator.pop(context);
                          await Hive.box("account").clear();
                          await FirebaseAuth.instance.signOut();
                          Navigator.pushReplacementNamed(
                              context, RoutesNames.loginPageName);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ).then((value) => value ?? false);
    }

    int indexPage = 0;

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(Duration(seconds: 1));
          _fetchData(context);
        },
        backgroundColor: theme.colorScheme.secondary,
        color: theme.colorScheme.primary,
        child: Scaffold(
          backgroundColor: theme.colorScheme.primary,
          body: StatefulBuilder(
            builder: (BuildContext context, setNavState) {
              return Stack(
                children: [
                  indexPage == 1
                      ? const CartPage()
                      : indexPage == 2
                          ? const WishListPage()
                          : BlocBuilder<GetProductsCubit, GetProductsState>(
                              builder: (context, getProductsState) {
                                if (getProductsState
                                    is GetProductsSuccessState) {
                                  List<Product> products =
                                      getProductsState.products;

                                  // Store all products for searching
                                  allProducts = products;

                                  // If search field is empty, show all products
                                  if (searchController.text.isEmpty) {
                                    filteredProducts = allProducts;
                                  }

                                  // Sort products by createdAt
                                  products.sort((a, b) =>
                                      b.createdAt.compareTo(a.createdAt));

                                  List<Product> wishList = [];
                                  products.forEach((element) {
                                    if (element.isFavorite == true) {
                                      wishList.add(element);
                                    }
                                  });
                                  BlocProvider.of<WishListCubit>(context)
                                      .addInitialWishListFromGotProducts(
                                          products: wishList);
                                  return Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10.w),
                                    width: double.infinity,
                                    height: double.infinity,
                                    child: ListView(
                                      children: [
                                        SizedBox(height: 60.h),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            childAspectRatio: 9 / 11,
                                            crossAxisCount:
                                                MediaQuery.of(context)
                                                            .size
                                                            .width >
                                                        370
                                                    ? 2
                                                    : 1,
                                            mainAxisSpacing: 30.h,
                                            crossAxisSpacing: 20.w,
                                          ),
                                          itemCount: filteredProducts.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.pushNamed(
                                                    context,
                                                    RoutesNames
                                                        .detailsProductPageName,
                                                    arguments: filteredProducts[
                                                        index]);
                                              },
                                              child: Container(
                                                child: ProductCard(
                                                    product: filteredProducts[
                                                        index]),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                } else if (getProductsState
                                    is FailGettingProductsState) {
                                  return Loading();
                                } else {
                                  return Loading();
                                }
                              },
                            ),
                  Positioned(
                    bottom: 15.h,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 400.w,
                      height: 80.h,
                      padding: EdgeInsets.only(
                        left: 40.w,
                        right: 40.w,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: GNav(
                          onTabChange: (value) {
                            print(value);
                            setNavState(() => indexPage = value);
                            indexPage == 3
                                ? showLogoutDialog(
                                    context, context.lang().localeName)
                                : null;
                          },
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(15),
                            vertical: ScreenUtil().setHeight(15),
                          ),
                          tabMargin: EdgeInsets.symmetric(
                              horizontal: 5.w, vertical: 5.h),
                          mainAxisAlignment: MainAxisAlignment.center,
                          backgroundColor: theme.colorScheme.secondary,
                          color: theme.colorScheme.primary,
                          activeColor: theme.colorScheme.secondary,
                          hoverColor: Colors.transparent,
                          tabBackgroundColor: theme.colorScheme.primary,
                          duration: const Duration(milliseconds: 500),
                          tabBorderRadius: 15,
                          iconSize: ScreenUtil().setSp(25),
                          tabs: const [
                            GButton(
                              icon: Icons.home_rounded,
                            ),
                            GButton(
                              icon: Icons.shopping_bag_rounded,
                            ),
                            GButton(
                              icon: Icons.favorite_rounded,
                            ),
                            GButton(
                              icon: Icons.logout_outlined,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  StatefulBuilder(
                    builder: (BuildContext context, setState) {
                      return indexPage != 0
                          ? SizedBox()
                          : Stack(
                              children: [
                                if (!showTextField)
                                  Positioned(
                                      top: 0,
                                      right: 0,
                                      child: MultiLanguageChanger()),
                                Positioned(
                                  top: 10.h,
                                  right: showTextField ? 10.w : null,
                                  left: showTextField ? null : 10.w,
                                  child: GestureDetector(
                                    onTap: () {
                                      if (showTextField == true) {
                                        searchController.clear();
                                      }
                                      setState(() {
                                        showTextField = !showTextField;
                                      });
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: theme.colorScheme.secondary,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: EdgeInsets.all(5.sp),
                                      child: Icon(
                                        showTextField
                                            ? Icons.cancel_outlined
                                            : Icons.search,
                                        color: theme.colorScheme.primary,
                                        size: 25.sp,
                                      ),
                                    ),
                                  ),
                                ),
                                if (showTextField)
                                  Positioned(
                                    top: 10.h,
                                    left: 10.w,
                                    child: Container(
                                      height: 40.h,
                                      width: 300.w,
                                      child: MyTextField(
                                        onChanged: (p0) {
                                          _onSearchChanged();
                                        },
                                        textInputAction: TextInputAction.search,
                                        icon: null,
                                        controller: searchController,
                                        title: ' ' +
                                            context
                                                .lang()
                                                .findWhatYouAreLookingFor +
                                            '...',
                                      ),
                                    ),
                                  ),
                              ],
                            );
                    },
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
