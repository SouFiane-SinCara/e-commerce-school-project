import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';

class AccountModel extends Account {
  const AccountModel({
    required super.fullName,
    required super.email,
    required super.password,
    required super.userId,
  });
  factory AccountModel.fromJson(Map data) {
    return AccountModel(
        fullName: data["fullName"],
        email: data["email"],
        password: data['password'],
        userId: data["userId"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "fullName": fullName,
      "email": email,
      "password": password,
    };
  }
}
