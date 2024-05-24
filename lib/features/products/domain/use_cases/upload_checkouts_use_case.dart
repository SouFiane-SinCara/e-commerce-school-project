import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/domain/repositories/product_repository.dart';

class UploadCheckoutsUseCase {
  ProductRepository productRepository;
  UploadCheckoutsUseCase({required this.productRepository});
  Future<Either<UploadCheckoutsFailure, Unit>> call(
      {required List<Checkout> checkouts}) {
    return productRepository.uploadCheckouts(checkouts: checkouts);
  }
}
