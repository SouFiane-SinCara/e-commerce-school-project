import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.colors,
    required super.sizes,
    required super.title,
    required super.image,
    required super.createdAt,
    required super.price,
    required super.description,
    required super.category,
    required super.stock,
    required super.isFavorite,
  });
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    print(json['title']);
    return ProductModel(
      id: json['id'],
      colors: List<String>.from(json['colors']),
      sizes: List<String>.from(json["sizes"]),
      title: json['title'],
      image: json['image'],
      createdAt: json['createdAt'],
      price: json["price"],
      description: json["description"],
      category: json["category"],
      stock: json["stock"],
      isFavorite: json["isFavorite"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "colors": colors,
      "sizes": sizes,
      "createdAt":createdAt,
      "title": title,
      "image": image,
      "price": price,
      "description": description,
      "category": category,
      "stock": stock,
      "isFavorite": isFavorite,
    };
  }
}
