import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final String id;
  final String title;
  final String image;
  final double price;
  final String description;
  final List<String> sizes;
  final int stock;
  final String category;
  final List<String> colors;
  bool ? isFavorite; // default false

  Product({
    required this.id,
    required this.colors,
    required this.sizes,
    required this.title,
    required this.image,
    required this.price,
    required this.description,
    required this.category,
    required this.stock,
    required this.isFavorite,
  });
  @override
  List<Object?> get props => [
        title,
        id,
        image,
        sizes,
        price,
        colors,
        stock,
        description,
        category,
        isFavorite,
      ];
}
