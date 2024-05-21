import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    ThemeData theme = context.themes();

    return Container(
      width: double.infinity,
      height: double.infinity,
      color: theme.colorScheme.primary,
    );
  }
}
