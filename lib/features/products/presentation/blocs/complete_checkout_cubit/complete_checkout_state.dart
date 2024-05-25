part of 'complete_checkout_cubit.dart';

sealed class CompleteCheckoutState extends Equatable {
  const CompleteCheckoutState();

  @override
  List<Object> get props => [];
}

final class CompleteCheckoutInitial extends CompleteCheckoutState {}
class LoadingCompleteCheckoutState extends CompleteCheckoutState{}
class CompleteCheckoutSuccess extends CompleteCheckoutState {
}
class CompleteCheckoutFailure extends CompleteCheckoutState {
  final Failures failure;
  const CompleteCheckoutFailure({required this.failure});
}