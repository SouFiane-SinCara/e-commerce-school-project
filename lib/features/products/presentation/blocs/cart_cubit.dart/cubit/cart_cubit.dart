import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:e_commerce_school_project/features/products/data/repositories_impl/product_repository_imp.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/domain/use_cases/add_to_cart_use_case.dart';
import 'package:e_commerce_school_project/features/products/domain/use_cases/delete_checkout_use_case.dart';
import 'package:e_commerce_school_project/features/products/domain/use_cases/get_cart_list_use_case.dart';
import 'package:equatable/equatable.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  List<Checkout> checkouts = [];
  CartCubit() : super(CartInitial());
  Future<void> addToCart(
      {Checkout? newCheckout, required Account account}) async {
    emit(LoadingCartState());
    print(checkouts.runtimeType);
    newCheckout == null ? null : checkouts.add(newCheckout);
    emit(UpdateCartState(checkouts: checkouts));
    if (newCheckout != null) {
      AddToCartUseCase addToCartUseCase = AddToCartUseCase(
          productRepository: ProductRepositoryImp(
              productsRemoteDataSource: ProductsRemoteDataSourceImp()));
      await addToCartUseCase.call(checkout: newCheckout, account: account);
    }
  }

  Future getCartList({required Account account}) async {
    emit(LoadingCartState());
    GetCartListUseCase getCartListUseCase = GetCartListUseCase(
        productRepository: ProductRepositoryImp(
            productsRemoteDataSource: ProductsRemoteDataSourceImp()));
    Either<GetCartListFailure, List<Checkout>> response =
        await getCartListUseCase.call(account: account);
    response.fold(
      (failure) {
        print("error");

        emit(ErrorCartState(failure: failure));
      },
      (cart) {
        print("good");
        checkouts = cart;
        emit(UpdateCartState(checkouts: checkouts));
      },
    );
  }

  Future deleteCheckout(
      {required Account account, required Checkout checkout}) async {
    checkouts.forEach(
      (element) {
        print("before:" + element.id.toString());
      },
    );
    emit(LoadingCartState());
    checkouts.remove(checkout);
    DeleteCheckoutUseCase deleteCheckoutUseCase = DeleteCheckoutUseCase(
      productRepository: ProductRepositoryImp(
          productsRemoteDataSource: ProductsRemoteDataSourceImp()),
    );
    await deleteCheckoutUseCase.call(account: account, checkout: checkout);
    checkouts.forEach(
      (element) {
        print("after:" + element.id.toString());
      },
    );
    emit(UpdateCartState(checkouts: checkouts));
  }
}
