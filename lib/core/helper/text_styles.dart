import 'package:flutter/material.dart';

///names of functions is equivalent to light theme
class TextStyles {
  // add a stong textStyle
  static const String normalFontStyle = "default";
  static TextStyle blackW600(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return theme.brightness == Brightness.light
        //light theme
        ? TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w600)
        //dark theme
        : TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w600);
  }

  static TextStyle blackW600WithShadow(BuildContext context) {
    ThemeData theme = Theme.of(context);

    return theme.brightness == Brightness.light
        //light theme
        ? TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            shadows: [
              BoxShadow(
                  color: theme.shadowColor,
                  blurRadius: 15,
                  offset: Offset(1, 1))
            ],
            fontWeight: FontWeight.w600)
        //dark theme
        : TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            shadows: [
              BoxShadow(
                  color: theme.shadowColor,
                  blurRadius: 15,
                  offset: Offset(1, 1))
            ],
            fontWeight: FontWeight.w600);
  }

  static TextStyle blackW900(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.brightness == Brightness.light
        //light theme
        ? TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w900)
        //dark theme
        : TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w900);
  }

  static TextStyle blackW900WithShadow(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.brightness == Brightness.light
        //light theme
        ? TextStyle(
            fontFamily: normalFontStyle,
            shadows: [
              BoxShadow(
                  color: theme.shadowColor,
                  blurRadius: 15,
                  offset: Offset(1, 1))
            ],
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w900)
        //dark theme
        : TextStyle(
            fontFamily: normalFontStyle,
            shadows: [
              BoxShadow(
                  color: theme.shadowColor,
                  blurRadius: 15,
                  offset: Offset(1, 1))
            ],
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w900);
  }

  static TextStyle blackW500(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.brightness == Brightness.light
        //light theme
        ? TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w500)
        //dark theme
        : TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w500);
  }

  static TextStyle blackW400(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.brightness == Brightness.light
        //light theme
        ? TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w400)
        //dark theme
        : TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w400);
  }

  static TextStyle greyW500(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.brightness == Brightness.light
        //light theme
        ? TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.onSecondary,
            fontWeight: FontWeight.w500)
        //dark theme
        : TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w500);
  }

  static TextStyle whiteW900(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return theme.brightness == Brightness.light
        //light theme
        ? TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w900)
        //dark theme
        : TextStyle(
            fontFamily: normalFontStyle,
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w900);
  }
}
