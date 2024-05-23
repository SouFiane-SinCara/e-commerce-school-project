part of 'wish_list_cubit.dart';

sealed class WishListState extends Equatable {
  const WishListState();

  @override
  List<Object> get props => [];
}

final class WishListInitial extends WishListState {}

class LoadingWishListState extends WishListState {}

class UpdateWishListState extends WishListState {
  final List<Product> wishList;
  const UpdateWishListState({required this.wishList});
}
