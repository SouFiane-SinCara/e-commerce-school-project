import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';

abstract class MultiLanguageRepository {
  Future<Either<MultiLanguageFailure, String>> getLanguage();
  Future<Either<MultiLanguageFailure, Unit>> storageLanguage({
    required String language,
  });
}
