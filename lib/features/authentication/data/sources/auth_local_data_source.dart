import 'package:e_commerce_school_project/core/errors/exceptions.dart';
import 'package:e_commerce_school_project/features/authentication/data/models/account_model.dart';
import 'package:e_commerce_school_project/features/authentication/domain/entities/account.dart';
import 'package:hive_flutter/hive_flutter.dart';

abstract class AuthLocalDataSource {
  Future cacheAccount({required AccountModel account});
  Future<Account> getCacheAccount();
}

class AuthLocalDataSourceHive extends AuthLocalDataSource {
  final String _accountKey = "account";
  @override
  Future cacheAccount({required AccountModel account}) async {
    Map<String, dynamic> accountJson = account.toJson();
  
    try {
      Box accountBox = await Hive.openBox(_accountKey);

      await accountBox.put(_accountKey, accountJson);
    } catch (e) {
      throw CacheAccountException();
    }
  }

  @override
  Future<Account> getCacheAccount() async {
    try {
      Box accountBox = await Hive.openBox(_accountKey);
      
      if (accountBox.isEmpty) {
        throw EmptyCacheAccountException();
      } else {
        Map json = await accountBox.get(_accountKey);

        return AccountModel.fromJson(json);
      }
    } catch (e) {
      throw CacheAccountException();
    }
  }
}
