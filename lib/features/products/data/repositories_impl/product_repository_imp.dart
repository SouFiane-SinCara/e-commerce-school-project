import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/exceptions.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/domain/repositories/product_repository.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';

class ProductRepositoryImp extends ProductRepository {
  ProductsRemoteDataSource productsRemoteDataSource;
  ProductRepositoryImp({required this.productsRemoteDataSource});
  @override
  Future<Either<GetProductsFailures, List<Product>>> getProducts(
      {required Account account}) async {
    try {
      List<Product> products =
          await productsRemoteDataSource.getProducts(account: account);
      return Right(products);
    } on ServerException {
      return Left(ServerGetProductsFailure());
    }
  }

  @override
  Future<Either<AddToWishListFailure, Unit>> addToWishList(
      {required Product product, required Account account}) async {
    try {
      await productsRemoteDataSource.addToWishList(
          account: account, product: product);
      return const Right(unit);
    } on ServerAddToWishListFailure {
      return Left(ServerAddToWishListFailure());
    }
  }

  @override
  Future<Either<DeleteFromWishListFailure, Unit>> deleteFromWishList(
      {required Product product, required Account account}) async {
    try {
      await productsRemoteDataSource.deleteFromWishList(
          product: product, account: account);
      return const Right(unit);
    } on ServerException {
      return Left(ServerDeleteFromWishListFailure());
    }
  }

  @override
  Future<Either<AddToCartFailure, Unit>> addToCart(
      {required Checkout checkout, required Account account}) async {
    try {
      await productsRemoteDataSource.addToCart(
          checkout: checkout, account: account);
      return const Right(unit);
    } on ServerException {
      return Left(AddToCartServerFailure());
    }
  }

  @override
  Future<Either<GetCartListFailure, List<Checkout>>> getCartList(
      {required Account account}) async {
    try {
      List<Checkout> cart =
          await productsRemoteDataSource.getCartList(account: account);
      return Right(cart);
    } on ServerException {
      return Left(GetCartListServerFailure());
    }
  }

  @override
  Future<Either<DeleteCheckoutFailure, Unit>> deleteCheckout(
      {required Account account, required Checkout checkout}) async {
    try {
      await productsRemoteDataSource.deleteCheckout(
          account: account, checkout: checkout);
      return Right(unit);
    } on ServerException {
      return Left(DeleteCheckoutServerFailure());
    }
  }
}
