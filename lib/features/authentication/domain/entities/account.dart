import 'package:equatable/equatable.dart';

class Account extends Equatable {
  final String fullName;
  final String email;
  final String password;
  final String userId;
  
  const Account(
      {required this.fullName, required this.email, required this.password,required this.userId});
  @override
  List<Object?> get props => [fullName, email, password,userId];
}
