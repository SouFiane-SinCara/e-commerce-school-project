import 'package:e_commerece_school_project/core/routing/my_router.dart';
import 'package:e_commerece_school_project/core/themes/dark.dart';
import 'package:e_commerece_school_project/core/themes/light.dart';
import 'package:e_commerece_school_project/features/authentication/logic/text_field_controllers_cubit/text_field_controllers_cubit.dart';
import 'package:e_commerece_school_project/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        ensureScreenSize: true,
        builder: (context, child) => MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => TextFieldControllersCubit(),
                ),
              ],
              child: MaterialApp(
                supportedLocales: L10n.all,
                locale: const Locale("en"),
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate
                ],
                
                theme: LightTheme().lightTheme,
                darkTheme: DarkTheme().darkTheme,
                debugShowCheckedModeBanner: false,
                onGenerateRoute: MyRouter().onGenerateRoute,
              ),
            ));
  }
}
