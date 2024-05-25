import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/products/data/data_sources/products_remote_data_source.dart';
import 'package:e_commerce_school_project/features/products/data/repositories_impl/product_repository_imp.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/domain/use_cases/upload_checkouts_use_case.dart';
import 'package:equatable/equatable.dart';

part 'complete_checkout_state.dart';

class CompleteCheckoutCubit extends Cubit<CompleteCheckoutState> {
  CompleteCheckoutCubit() : super(CompleteCheckoutInitial());
  Future<void> uploadCheckouts({required List<Checkout> checkouts}) async {
    emit(LoadingCompleteCheckoutState());
    UploadCheckoutsUseCase uploadCheckoutsUseCase = UploadCheckoutsUseCase(
        productRepository: ProductRepositoryImp(
            productsRemoteDataSource: ProductsRemoteDataSourceImp()));
    Either response = await uploadCheckoutsUseCase.call(checkouts: checkouts);
    response.fold(
      (l) {
        emit(CompleteCheckoutFailure(failure: l));
      },
      (r) {
        emit(CompleteCheckoutSuccess());
      },
    );
  }
}
