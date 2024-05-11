import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/multi_language/domain/repository/multi_language_repository.dart';

class StorageLanguageUseCase {
  MultiLanguageRepository multiLanguageRepository;

  StorageLanguageUseCase({required this.multiLanguageRepository});
  Future<Either<MultiLanguageFailure, Unit>> call({required String language}) {
    return multiLanguageRepository.storageLanguage(language: language);
  }
}
