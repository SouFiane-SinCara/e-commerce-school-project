part of 'language_changer_cubit.dart';

@immutable
sealed class LanguageChangerState {}

final class LanguageChangerInitial extends LanguageChangerState {}

final class ChangedLanguageChangerState extends LanguageChangerState {
  final Locale locale;
  ChangedLanguageChangerState({required this.locale});
}
