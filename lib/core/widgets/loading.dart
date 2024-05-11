import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: context.themes().colorScheme.primary,
        alignment: Alignment.center,
        child: CircularProgressIndicator(
          color: context.themes().colorScheme.secondary,
          
        ),
      ),
    );
  }
}
