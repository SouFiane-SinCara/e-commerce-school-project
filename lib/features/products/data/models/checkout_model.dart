import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';

class CheckoutModel extends Checkout {
  CheckoutModel(
      {required super.productId,
      super.id,
      super.phoneNumber,
      super.shippingAddress,
      super.date,
      super.time,
      required super.title,
      required super.image,
      required super.price,
      required super.description,
      required super.size,
      required super.category,
      required super.color,
      required super.quantity,
      required super.fullName,
      required super.email});
  factory CheckoutModel.fromJson({required Map<String, dynamic> json}) {
    return CheckoutModel(
        date: json['date'],
        time: json['time'],
        id: json['id'],
        phoneNumber: json['phoneNumber'],
        shippingAddress: json['shippingAddress'],
        productId: json['productId'],
        title: json['title'],
        image: json['image'],
        price: json['price'],
        description: json['description'],
        size: json['size'],
        category: json['category'],
        color: json['color'],
        quantity: json['quantity'],
        fullName: json['fullName'],
        email: json['email']);
  }
  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
      "title": title,
      "image": image,
      "price": price,
      "description": description,
      "size": size,
      "category": category,
      "color": color,
      "quantity": quantity,
      "fullName": fullName,
      "email": email,
      "date": date,
      "time": time,
      "id": id,
      "phoneNumber": phoneNumber,
      "shippingAddress": shippingAddress,
    };
  }
}
