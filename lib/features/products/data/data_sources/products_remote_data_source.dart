import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce_school_project/core/errors/exceptions.dart';
import 'package:e_commerce_school_project/core/errors/failures.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:e_commerce_school_project/features/products/data/models/checkout_model.dart';
import 'package:e_commerce_school_project/features/products/data/models/product_model.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/checkout.dart';
import 'package:e_commerce_school_project/features/products/domain/entities/product.dart';
import 'package:firebase_core/firebase_core.dart';

abstract class ProductsRemoteDataSource {
  Future<List<Product>> getProducts({required Account account});
  Future addToWishList({required Product product, required Account account});
  Future deleteFromWishList(
      {required Product product, required Account account});
  Future addToCart({required Checkout checkout, required Account account});
  Future<List<Checkout>> getCartList({required Account account});
  Future deleteCheckout({required Account account, required Checkout checkout});
  Future uploadCheckouts({required List<Checkout> checkouts});
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

  @override
  Future addToCart(
      {required Checkout checkout, required Account account}) async {
    try {
      FirebaseFirestore firebase = FirebaseFirestore.instance;

      CheckoutModel checkoutModel = CheckoutModel(
        productId: checkout.productId,
        title: checkout.title,
        image: checkout.image,
        price: checkout.price,
        description: checkout.description,
        size: checkout.size,
        category: checkout.category,
        color: checkout.color,
        quantity: checkout.quantity,
        fullName: checkout.fullName,
        email: checkout.email,
      );

      DocumentReference docRef = await firebase
          .collection("users")
          .doc(account.userId)
          .collection("Cart")
          .add(checkoutModel.toJson());

      String documentId = docRef.id;

      await docRef.update({
        'id': documentId,
      });

      checkoutModel.id = documentId;
      checkout.id = documentId;
    } catch (e) {
      throw ServerException;
    }
  }

  @override
  Future<List<Checkout>> getCartList({required Account account}) async {
    try {
      FirebaseFirestore fb = FirebaseFirestore.instance;
      final data = await fb
          .collection("users")
          .doc(account.userId)
          .collection("Cart")
          .get();
      List<Checkout> cart = [];
      data.docs.forEach(
        (element) {
          print("elemente : ${element.data()['id']}");
          Checkout checkout = CheckoutModel.fromJson(json: element.data());
          cart.add(checkout);
        },
      );

      return cart;
    } catch (e) {
      print(e);
      throw ServerException();
    }
  }

  @override
  Future deleteCheckout(
      {required Account account, required Checkout checkout}) async {
    try {
      FirebaseFirestore fb = FirebaseFirestore.instance;
      await fb
          .collection("users")
          .doc(account.userId)
          .collection("Cart")
          .doc(checkout.id)
          .delete();
    } catch (e) {
      print(e);
      throw DeleteCheckoutServerFailure();
    }
  }

  @override
  Future uploadCheckouts({required List<Checkout> checkouts}) async {
    CheckoutModel model;
    try {
      FirebaseFirestore fb = FirebaseFirestore.instance;
      checkouts.forEach(
        (element) async {
          print(element.time);
          model = CheckoutModel(
              date: element.date,
              phoneNumber: element.phoneNumber,
              shippingAddress: element.shippingAddress,
              time: element.time,
              productId: element.productId,
              title: element.title,
              image: element.image,
              price: element.price,
              description: element.description,
              size: element.size,
              category: element.category,
              color: element.color,
              quantity: element.quantity,
              fullName: element.fullName,
              email: element.email);
          DocumentReference docRef =
              await fb.collection("orders").add(model.toJson());
          String docId = docRef.id;
          docRef.update({
            "id": docId,
          });
        },
      );
    } catch (e) {
      throw ServerException();
    }
  }
}
