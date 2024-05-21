import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:e_commerce_school_project/features/products/data/repositories_impl/product_repository_imp.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';
import 'package:e_commerce_school_project/features/products/domain/use_cases/get_products_use_case.dart';
import 'package:e_commerce_school_project/features/products/presentation/blocs/cubit/wish_list_cubit.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';

part 'get_products_state.dart';

class GetProductsCubit extends Cubit<GetProductsState> {
  List<Product> products = [];
  GetProductsCubit() : super(GetProductsInitial());
  void getProducts({required Account account}) async {
    emit(GettingProductsState());
    GetProductsUseCase getProductsUseCase = GetProductsUseCase(
        productRepository: ProductRepositoryImp(
            productsRemoteDataSource: ProductsRemoteDataSourceImp()));
    Either response = await getProductsUseCase.call(account: account);
    response.fold((failure) {
      emit(FailGettingProductsState(failure));
    }, (products) {
      this.products = products;

      emit(GetProductsSuccessState(products));
    });
  }
}
