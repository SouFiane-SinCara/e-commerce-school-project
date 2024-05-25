part of 'get_products_cubit.dart';

sealed class GetProductsState extends Equatable {
  const GetProductsState();

  @override
  List<Object> get props => [];
}

final class GetProductsInitial extends GetProductsState {}

class GettingProductsState extends GetProductsState {}

class GetProductsSuccessState extends GetProductsState {
  final List<Product> products;
  const GetProductsSuccessState(this.products);
  @override
  List<Object> get props => [products];
}

class FailGettingProductsState extends GetProductsState {
  final GetProductsFailures failure;
  const FailGettingProductsState(this.failure);
  @override
  List<Object> get props => [failure];
}
