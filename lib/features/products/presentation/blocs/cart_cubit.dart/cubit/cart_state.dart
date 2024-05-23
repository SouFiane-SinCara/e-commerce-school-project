part of 'cart_cubit.dart';

sealed class CartState extends Equatable {
  const CartState();

  @override
  List<Object> get props => [];
}

final class CartInitial extends CartState {}

class LoadingCartState extends CartState {}

class ErrorCartState extends CartState {
  final Failures failure;
  const ErrorCartState({required this.failure});
}

class UpdateCartState extends CartState {
  List<Checkout> checkouts;
  UpdateCartState({required this.checkouts});
}
