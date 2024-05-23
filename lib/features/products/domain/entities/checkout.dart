import 'package:equatable/equatable.dart';

class Checkout extends Equatable {
  final String productId;
   String? id;
  final String title;
  final String image;
  final double price;
  final String description;
  final String? size;
  final String category;
  final String? color;
  final int quantity;
  final String? shippingAddress;
  final String? phoneNumber;
  final String fullName;
  final String email;
  final String? time;
  final String? date;

   Checkout({
    this.id,
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.size,
    required this.category,
    required this.color,
    required this.quantity,
    this.shippingAddress,
    this.phoneNumber,
    required this.fullName,
    required this.email,
    this.time,
    this.date,
  });
  @override
  List<Object?> get props => [
        productId,
        title,
        id,
        image,
        price,
        description,
        size,
        category,
        title,
        productId,
        color,
        quantity,
        shippingAddress,
        phoneNumber,
        fullName,
        email,
        time,
        date,
      ];
}
