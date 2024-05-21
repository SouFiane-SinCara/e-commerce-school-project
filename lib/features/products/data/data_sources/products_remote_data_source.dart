import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_school_project/core/errors/exceptions.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/data/models/product_model.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';

abstract class ProductsRemoteDataSource {
  Future<List<Product>> getProducts({required Account account});
  Future addToWishList({required Product product, required Account account});
  Future deleteFromWishList(
      {required Product product, required Account account});
}

class ProductsRemoteDataSourceImp extends ProductsRemoteDataSource {
  @override
  Future<List<Product>> getProducts({required Account account}) async {
    List<Product> products = [];
    try {
      final FirebaseFirestore fireStore = FirebaseFirestore.instance;
      final productData = await fireStore.collection("products").get();
      final wishListData = await fireStore
          .collection("users")
          .doc(account.userId)
          .collection("wishList")
          .get();

      bool isWishList;
      productData.docs.forEach(
        (productElement) {
          isWishList = false;
          wishListData.docs.forEach(
            (wishlistProduct) {
              if (productElement.data()['id'] == wishlistProduct.data()['id']) {
                print("found:${productElement.data()["title"]}");
                isWishList = true;
              }
            },
          );
          ProductModel productModel =
              ProductModel.fromJson(productElement.data());
          products.add(
            Product(
              id: productModel.id,
              colors: productModel.colors,
              sizes: productModel.sizes,
              title: productModel.title,
              image: productModel.image,
              price: productModel.price,
              description: productModel.description,
              category: productModel.category,
              stock: productModel.stock,
              isFavorite: isWishList,
            ),
          );
        },
      );
    } on FirebaseException catch (e) {
      print("errore:" + e.code.toString());
      throw ServerException();
    }
    return products;
  }

  @override
  Future addToWishList(
      {required Product product, required Account account}) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      ProductModel productModel = ProductModel(
        id: product.id,
        colors: product.colors,
        sizes: product.sizes,
        title: product.title,
        image: product.image,
        price: product.price,
        description: product.description,
        category: product.category,
        stock: product.stock,
        isFavorite: product.isFavorite,
      );
      await firebaseFirestore
          .collection("users")
          .doc(account.userId)
          .collection("wishList")
          .doc(product.id)
          .set(productModel.toJson());
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future deleteFromWishList(
      {required Product product, required Account account}) async {
    try {
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      print("try delete${product.id}");
      await firebaseFirestore
          .collection("users")
          .doc(account.userId)
          .collection("wishList")
          .doc(product.id)
          .delete();
    } on FirebaseException {
      throw ServerException();
    }
  }
}
