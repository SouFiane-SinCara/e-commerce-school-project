import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/multi_language/data/source/multi_language_local_data_source.dart';
import 'package:e_commerce_school_project/features/multi_language/domain/repository/multi_language_repository.dart';

class MultiLanguageRepositoryImp extends MultiLanguageRepository {
  MultiLanguageLocalDataSource multiLanguageLocalDataSource;
  MultiLanguageRepositoryImp({required this.multiLanguageLocalDataSource});
  @override
  Future<Either<MultiLanguageFailure, String>> getLanguage() async {
    try {
      String language = await multiLanguageLocalDataSource.getLanguage();
      return Right(language);
    } catch (e) {
      return Left(NonLanguageSelectedFailure());
    }
  }

  @override
  Future<Either<MultiLanguageFailure, Unit>> storageLanguage(
      {required String language}) async {
    try {
      await multiLanguageLocalDataSource.storageLanguage(language: language);
      return const Right(unit);
    } catch (e) {
      return Left(NonLanguageSelectedFailure());
    }
  }
}
