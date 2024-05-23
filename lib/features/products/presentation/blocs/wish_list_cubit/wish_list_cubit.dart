import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/core/widgets/loading.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:e_commerce_school_project/features/products/data/repositories_impl/product_repository_imp.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';
import 'package:e_commerce_school_project/features/products/domain/use_cases/add_to_wish_list_use_case.dart';
import 'package:e_commerce_school_project/features/products/domain/use_cases/delete_from_wish_list_use_case.dart';
import 'package:equatable/equatable.dart';

part 'wish_list_state.dart';

class WishListCubit extends Cubit<WishListState> {
  List<Product> wishList = [];
  WishListCubit() : super(WishListInitial());
  Future<void> addToWishList(
      {Product? product, required Account account}) async {
    emit(LoadingWishListState());
    product == null ? null : wishList.add(product);

    emit(UpdateWishListState(wishList: wishList));
    if (product != null) {
      await AddToWishListUseCase(
              productRepository: ProductRepositoryImp(
                  productsRemoteDataSource: ProductsRemoteDataSourceImp()))
          .call(account: account, product: product);
    }
  }

  void addInitialWishListFromGotProducts({required List<Product> products}) {
    emit(LoadingWishListState());
    wishList = products;
    emit(UpdateWishListState(wishList: products));
  }

  Future<void> deleteFromWishList(
      {required Product product, required Account account}) async {
    emit(LoadingWishListState());
    wishList.remove(product);
    emit(UpdateWishListState(wishList: wishList));
    DeleteFromWishListUseCase deleteFromWishListUseCase =
        DeleteFromWishListUseCase(
            productRepository: ProductRepositoryImp(
                productsRemoteDataSource: ProductsRemoteDataSourceImp()));
    await deleteFromWishListUseCase.call(product: product, account: account);
  }
}
