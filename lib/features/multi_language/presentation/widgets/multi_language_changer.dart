import 'package:e_commerce_school_project/core/helper/extension.dart';
import 'package:e_commerce_school_project/core/helper/text_styles.dart';
import 'package:e_commerce_school_project/features/multi_language/presentation/logic/language_changer_cubit/language_changer_cubit.dart';
import 'package:e_commerce_school_project/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MultiLanguageChanger extends StatefulWidget {
  const MultiLanguageChanger({super.key});

  @override
  State<MultiLanguageChanger> createState() => _MultiLanguageChangerState();
}

class _MultiLanguageChangerState extends State<MultiLanguageChanger> {
  String currentLang = L10n.languages[0]['local'];

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    List<DropdownMenuItem<String>> items = [
      DropdownMenuItem(
        value: L10n.languages[0]['local'],
        child: Text(
          L10n.languages[0]['language'],
          style: TextStyles.blackW600WithShadow(context),
        ),
      ),
      DropdownMenuItem(
        value: L10n.languages[1]['local'],
        child: Text(
          L10n.languages[1]['language'],
          style: TextStyles.blackW600WithShadow(context),
        ),
      )
    ];

    return Row(
      children: [
        BlocBuilder<LanguageChangerCubit, LanguageChangerState>(
          builder: (context, state) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 5.w),
              child: DropdownButton(
                elevation: 2,
                dropdownColor: theme.colorScheme.primary,
                borderRadius: BorderRadius.circular(15),
                style: TextStyles.blackW600WithShadow(context),
                underline: const SizedBox(),
                items: items,
                value: state is ChangedLanguageChangerState
                    ? state.locale.languageCode
                    : currentLang,
                onChanged: (value) {
                  BlocProvider.of<LanguageChangerCubit>(context)
                      .changeLanguage(Locale(value!));
                },
              ),
            );
          },
        )
      ],
    );
  }
}
