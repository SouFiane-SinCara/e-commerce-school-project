import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/domain/repositories/product_repository.dart';

class GetCartListUseCase {
  ProductRepository productRepository;
  GetCartListUseCase({required this.productRepository});
  Future<Either<GetCartListFailure, List<Checkout>>> call(
      {required Account account}) {
    return productRepository.getCartList(account: account);
  }
}
