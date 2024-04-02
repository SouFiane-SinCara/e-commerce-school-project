import 'package:e_commerece_school_project/core/helper/extension.dart';
import 'package:e_commerece_school_project/core/helper/text_styles.dart';
import 'package:e_commerece_school_project/core/routing/routes_name.dart';
import 'package:e_commerece_school_project/features/products/presentation/screens/initial_page.dart';
import 'package:e_commerece_school_project/features/products/presentation/screens/login_page.dart';
import 'package:e_commerece_school_project/features/products/presentation/screens/signup_page.dart';
import 'package:flutter/material.dart';

class MyRouter {
  Route<dynamic> onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesNames.initialRoutePageName:
        return MaterialPageRoute(
          builder: (context) => const InitialPage(),
        );
      case RoutesNames.loginPageName:
        return MaterialPageRoute(
          builder: (context) => LoginPage(),
        );
      case RoutesNames.signUpPageName:
        return MaterialPageRoute(
          builder: (context) => SignupPage(),
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
