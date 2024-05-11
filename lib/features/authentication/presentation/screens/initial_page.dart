import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_cubit/Auth_cubit.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/screens/login_page.dart';
import 'package:e_commerce_school_project/features/products/presentation/pages/products_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is LoginSuccessState) {
          return const ProductsPage();
        } else {
          return const LoginPage();
        } 
      },
    );
  }
}
