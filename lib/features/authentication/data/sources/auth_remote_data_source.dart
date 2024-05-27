import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:e_commerce_school_project/core/errors/exceptions.dart';
import 'package:e_commerce_school_project/features/authentication/data/models/account_model.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRemoteDataSource {
  Future<Account> login({
    required String email,
    required String password,
  });
  Future<Account> signUP({
    required String email,
    required String fullName,
    required String password,
  });
  Future forgotPassword({required String email});
}

class AuthRemoteDataSourceImp extends AuthRemoteDataSource {
  bool isEmail(String em) {
    final RegExp regex =
        RegExp(r'^[a-zA-Z0-9.a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return regex.hasMatch(em);
  }

  @override
  Future<Account> login({
    required String email,
    required String password,
  }) async {
    if (!isEmail(email)) {
      throw EmailBadFormatException();
    } else if (password.length < 8) {
      throw WeakPasswordException();
    } else {
      try {
        FirebaseAuth firebaseAuth = FirebaseAuth.instance;
        UserCredential user = await firebaseAuth
            .signInWithEmailAndPassword(email: email, password: password)
            .whenComplete(() => null);
        FirebaseFirestore fireStore = FirebaseFirestore.instance;
        DocumentSnapshot<Map<String, dynamic>> data =
            await fireStore.collection("users").doc(user  .user!.uid).get();
        return AccountModel.fromJson(data.data()!);
      } on FirebaseException catch (e) {
        print("failure ex:" + e.code.toString());
        if (e.code == "invalid-email") {
          throw EmailBadFormatException();
        } else if (e.code == "network-request-failed" || e.code == "unknown") {
          throw NonInternetConnectionException();
        } else if (e.code == "invalid-credential") {
          throw WrongPasswordOrEmailException();
        } else {
          throw ServerException();
        }
      }
    }
  }

  @override
  Future<Account> signUP({
    required String email,
    required String fullName,
    required String password,
  }) async {
    FirebaseAuth fbAuth = FirebaseAuth.instance;
    late UserCredential user;
    if (!isEmail(email)) {
      throw EmailBadFormatException();
    } else if (password.length < 8) {
      throw WeakPasswordException();
    } else {
      try {
        user = await fbAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        FirebaseFirestore fireStore = FirebaseFirestore.instance;
        await fireStore.collection("users").doc(user.user!.uid).set({
          "userId": user.user!.uid,
          "fullName": fullName,
          "email": email,
          "password": password,
        });
        return Account(
            fullName: fullName,
            email: email,
            password: password,
            userId: user.user!.uid);
      } on FirebaseException catch (e) {
        if (e.code == "invalid-email") {
          throw EmailBadFormatException();
        } else if (e.code == "weak-password") {
          throw WeakPasswordException();
        } else if (e.code == "invalid-credential") {
          throw WrongPasswordOrEmailException();
        } else if (e.code == "email-already-in-use") {
          throw EmailAlreadyUsedException();
        } else if (e.code == "network-request-failed" || e.code == "unknown") {
          throw NonInternetConnectionException();
        } else {
          throw ServerException();
        }
      }
    }
  }

  @override
  Future forgotPassword({required String email}) async {
    FirebaseAuth fbAuth = FirebaseAuth.instance;
    FirebaseFirestore fireStore = FirebaseFirestore.instance;
    if (!isEmail(email)) {
      throw EmailBadFormatException();
    }
    try {
      final getter = await fireStore
          .collection("users")
          .where("email", isEqualTo: email)
          .get();
      bool isRegistred = getter.docs.length > 0;
      if (!isRegistred) {
        throw NotRegisteredException();
      }
      await fbAuth.sendPasswordResetEmail(email: email);
      print("errore: done $email");
    } on FirebaseException catch (e) {
      print("errore: ${e.code}");
      if (e.code == "invalid-email") {
        throw EmailBadFormatException();
      } else if (e.code == "network-request-failed" || e.code == "unknown") {
        throw NonInternetConnectionException();
      } else {
        throw ServerException();
      }
    }
  }
}
