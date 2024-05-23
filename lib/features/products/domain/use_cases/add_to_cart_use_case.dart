import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/domain/repositories/product_repository.dart';

class AddToCartUseCase {
  ProductRepository productRepository;
  AddToCartUseCase({required this.productRepository});
  Future<Either<AddToCartFailure, Unit>> call(
      {required Checkout checkout, required Account account}) {
    return productRepository.addToCart(checkout: checkout, account: account);
  } 
}
