import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
extension MyExtensions on BuildContext{
   ThemeData themes(){
      return Theme.of(this);
  }
  navigate(String routeName){
    Navigator.pushNamed(this, routeName);
  }
  AppLocalizations lang(){
    return AppLocalizations.of(this)!;
  } 
}
