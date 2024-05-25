import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/domain/repositories/product_repository.dart';

class DeleteCheckoutUseCase {
  ProductRepository productRepository;
  DeleteCheckoutUseCase({required this.productRepository});
  Future<Either<DeleteCheckoutFailure, Unit>> call(
      {required Account account, required Checkout checkout}) {
    return productRepository.deleteCheckout(
        account: account, checkout: checkout);
  }
}
