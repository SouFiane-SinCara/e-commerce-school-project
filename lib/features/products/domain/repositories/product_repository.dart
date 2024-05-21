import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';

abstract class ProductRepository {
  Future<Either<GetProductsFailures, List<Product>>> getProducts(
      {required Account account});
  Future<Either<AddToWishListFailure, Unit>> addToWishList(
      {required Product product, required Account account});
  Future<Either<DeleteFromWishListFailure, Unit>> deleteFromWishList(
      {required Product product, required Account account});
}
