import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';

class Product extends Equatable {
  final String title;
  final String image;
  final double price;
  final double rate;
  final String description;
  final List<String> sizes;
  final int stock;
  final String category;
  final List<Color> colors;
  final bool isFavorite; // default false
  final bool isCart; // default false
  const   Product({
    required this.colors,
    required this.sizes,
    required this.title,
    required this.rate,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
    required this.stock,
    required this.isFavorite,
    required this.isCart,
  });
  @override
  List<Object?> get props => [
        title,
        image,
        sizes,
        rate,
        price,
        colors,
        stock,
        description,
        category,
        isFavorite,
        isCart,
      ];
}
