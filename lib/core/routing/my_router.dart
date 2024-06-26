import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/core/routing/routes_name.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/screens/forgot_password_page.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/screens/login_page.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/screens/signup_page.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';
import 'package:e_commerce_school_project/features/products/presentation/screens/complete_checkout.dart';
import 'package:e_commerce_school_project/features/products/presentation/screens/details_products_page.dart';
import 'package:e_commerce_school_project/features/products/presentation/screens/products_page.dart';
import 'package:flutter/material.dart';

class MyRouter {
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesNames.loginPageName:
        return MaterialPageRoute(
          builder: (context) => const LoginPage(),
        );
      case RoutesNames.signUpPageName:
        return MaterialPageRoute(
          builder: (context) => SignUpPage(),
        );
      case RoutesNames.forgotPasswordPageName:
        return MaterialPageRoute(
          builder: (context) => ForgotPasswordPage(),
        );
      case RoutesNames.productsPageName:
        return MaterialPageRoute(
          builder: (context) =>  ProductsPage(),
        );
      case RoutesNames.detailsProductPageName:
        return MaterialPageRoute(
          builder: (context) => DetailsProductsPage(
            product: routeSettings.arguments as Product,
          ),
        );
      case RoutesNames.completeCheckoutName:
        return MaterialPageRoute(
          builder: (context) => CompleteCheckout(),
        );

      default:
        return MaterialPageRoute(
          builder: (context) => Scaffold(
            body: Container(
              width: double.infinity,
              height: double.infinity,
              color: context.themes().scaffoldBackgroundColor,
              child: Center(
                child: Text(
                  context.lang().pagenotfound,
                  style: TextStyles.blackW600(context),
                ),
              ),
            ),
          ),
        );
    }
  }
}
