import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';
import 'package:e_commerce_school_project/features/products/domain/repositories/product_repository.dart';

class GetProductsUseCase {
  ProductRepository productRepository;
  GetProductsUseCase({required this.productRepository});
  Future<Either<GetProductsFailures, List<Product>>> call({required Account account}) async {
    return productRepository.getProducts(account: account);
  }
}
