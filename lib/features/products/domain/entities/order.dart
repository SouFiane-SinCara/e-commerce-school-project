import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final String id;
  final String title;
  final String image;
  final double price;
  final String description;
  final String size;
  final String category;
  final String color;
  final int quantity;
  final String shippingAddress;
  final String phoneNumber;
  final String fullName;
  final String email;
  final String time;
  final String date;

  const Order({
    required this.id,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.size,
    required this.category,
    required this.color,
    required this.quantity,
    required this.shippingAddress,
    required this.phoneNumber,
    required this.fullName,
    required this.email,
    required this.time,
    required this.date,
  });
  @override
  List<Object?> get props => [
        id,
        title,
        image,
        price,
        description,
        size,
        category,
        title,
        id,
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
