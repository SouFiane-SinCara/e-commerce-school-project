import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';
import 'package:e_commerce_school_project/features/products/domain/repositories/product_repository.dart';

class AddToWishListUseCase {
  ProductRepository productRepository;
  AddToWishListUseCase({required this.productRepository});
  Future<Either<AddToWishListFailure, Unit>> call(
      {required Account account, required Product product}) {
    return productRepository.addToWishList(account: account, product: product);
  }
}
