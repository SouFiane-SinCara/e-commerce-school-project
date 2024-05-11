import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/multi_language/domain/repository/multi_language_repository.dart';

class GetLanguageUseCase {
  MultiLanguageRepository multiLanguageRepository;
  GetLanguageUseCase({required this.multiLanguageRepository});
  Future<Either<MultiLanguageFailure, String>> call() {
    return multiLanguageRepository.getLanguage();
  }
}
