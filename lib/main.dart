import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_controllers_cubit/Auth_controllers_cubit.dart';
import 'package:e_commerce_school_project/features/authentication/presentation/logic/Auth_cubit/Auth_cubit.dart';
 import 'package:e_commerce_school_project/features/multi_language/presentation/logic/language_changer_cubit/language_changer_cubit.dart';
import 'package:e_commerce_school_project/core/routing/my_router.dart';
import 'package:e_commerce_school_project/core/themes/dark.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/themes/light.dart';

import 'package:e_commerce_school_project/l10n/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Firebase.initializeApp();
  
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (context) => LanguageChangerCubit()..getLanguage()),
        BlocProvider(create: (context) => AuthCubit()),
        BlocProvider(create: (context) => AuthControllersCubit()),
      ],
      child: ScreenUtilInit(
          designSize: const Size(360, 690),
          minTextAdapt: true,
          ensureScreenSize: true,
          builder: (context, child) =>
              BlocBuilder<LanguageChangerCubit, LanguageChangerState>(
                builder: (context, state) {
                  return MaterialApp(
                    supportedLocales: L10n.all,
                    locale: state is ChangedLanguageChangerState
                        ? state.locale
                        : const Locale("en"),
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
                  );
                },
              )),
    );
  }
}
