import 'package:equatable/equatable.dart';

abstract class Failures extends Equatable {}

abstract class LoginFailures extends Failures {}

class ServerLoginFailure extends LoginFailures {
  @override
  List<Object?> get props => [];
}

class EmailBadFormatLoginFailure extends LoginFailures {
  @override
  List<Object?> get props => [];
}

class WrongPasswordOrEmailFailure extends LoginFailures {
  @override
  List<Object?> get props => [];
}

class WeakPasswordLoginFailure extends LoginFailures {
  @override
  List<Object?> get props => [];
}

class NonInternetConnectionLoginFailure extends LoginFailures {
  @override
  List<Object?> get props => [];
}

abstract class SignUpFailures extends Failures {}

class ServerSignUpFailure extends SignUpFailures {
  @override
  List<Object?> get props => [];
}

class EmailAlreadyUsedFailure extends SignUpFailures {
  @override
  List<Object?> get props => [];
}

class WeakPasswordSignUpFailure extends SignUpFailures {
  @override
  List<Object?> get props => [];
}

class NonInternetConnectionSignUpFailure extends SignUpFailures {
  @override
  List<Object?> get props => [];
}

class EmailBadFormatSignUpFailure extends SignUpFailures {
  @override
  List<Object?> get props => [];
}

abstract class CacheAccountFailure extends Failures {}

class GeneralCacheAccountFailure extends CacheAccountFailure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheAccountFailure extends CacheAccountFailure {
  @override
  List<Object?> get props => [];
}

abstract class MultiLanguageFailure extends Failures {}

class NonLanguageSelectedFailure extends MultiLanguageFailure {
  @override
  List<Object?> get props => [];
}

abstract class ForgotPasswordFailure extends Failures {}

class EmailBadFormatForgotPasswordFailure extends ForgotPasswordFailure {
  @override
  List<Object?> get props => [];
}

class NotRegisterFailure extends ForgotPasswordFailure {
  @override
  List<Object?> get props => [];
}

class ServerForgotPasswordFailure extends ForgotPasswordFailure {
  @override
  List<Object?> get props => [];
}

class NonInternetConnectionForgotPasswordFailure extends ForgotPasswordFailure {
  @override
  List<Object?> get props => [];
}

abstract class GetProductsFailures extends Failures {}

class ServerGetProductsFailure extends GetProductsFailures {
  @override
  List<Object?> get props => [];
}

abstract class AddToWishListFailure extends Failures {}

class ServerAddToWishListFailure extends AddToWishListFailure {
  @override
  List<Object?> get props => [];
}

abstract class DeleteFromWishListFailure extends Failures {}

class ServerDeleteFromWishListFailure extends DeleteFromWishListFailure {
  @override
  List<Object?> get props => [];
}

abstract class AddToCartFailure extends Failures {}

class AddToCartServerFailure extends AddToCartFailure {
  @override
  List<Object?> get props => [];
}
abstract class GetCartListFailure extends Failures {}

class GetCartListServerFailure extends GetCartListFailure {
  @override
  List<Object?> get props => [];
}
abstract class DeleteCheckoutFailure extends Failures {}

class  DeleteCheckoutServerFailure extends DeleteCheckoutFailure {
  @override
  List<Object?> get props => [];
}
