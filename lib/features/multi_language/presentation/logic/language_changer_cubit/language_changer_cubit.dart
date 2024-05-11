import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/multi_language/data/repository_imp/multi_language_repository_imp.dart';
import 'package:e_commerce_school_project/features/multi_language/data/source/multi_language_local_data_source.dart';
import 'package:e_commerce_school_project/features/multi_language/domain/usecases/get_language_use_case.dart';
import 'package:e_commerce_school_project/features/multi_language/domain/usecases/storage_language_use_case.dart';
import 'package:flutter/material.dart';

part 'language_changer_state.dart';

class LanguageChangerCubit extends Cubit<LanguageChangerState> {
  LanguageChangerCubit() : super(LanguageChangerInitial());
  StorageLanguageUseCase storageLanguageUseCase = StorageLanguageUseCase(
      multiLanguageRepository: MultiLanguageRepositoryImp(
          multiLanguageLocalDataSource: MultiLanguageLocalDataSourceHive()));
  GetLanguageUseCase getLanguageUseCase = GetLanguageUseCase(
      multiLanguageRepository: MultiLanguageRepositoryImp(
          multiLanguageLocalDataSource: MultiLanguageLocalDataSourceHive()));
  void changeLanguage(Locale locale) {
    emit(LanguageChangerInitial());
    storageLanguageUseCase.call(language: locale.languageCode);
    emit(ChangedLanguageChangerState(locale: locale));
  }

  Future<void> getLanguage() async {
    emit(LanguageChangerInitial());
    Either<MultiLanguageFailure, String> response =
        await getLanguageUseCase.call();
    response.fold((l) {
      emit(ChangedLanguageChangerState(locale: const Locale("en")));
    }, (r) {
      emit(ChangedLanguageChangerState(locale: Locale(r)));
    });
  }
}
