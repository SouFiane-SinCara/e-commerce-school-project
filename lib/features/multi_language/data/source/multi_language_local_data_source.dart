import 'package:hive_flutter/hive_flutter.dart';

abstract class MultiLanguageLocalDataSource {
  Future storageLanguage({required String language});
  Future<String> getLanguage();
}

class MultiLanguageLocalDataSourceHive extends MultiLanguageLocalDataSource {
  @override
  Future<String> getLanguage() async {
    Box languageBox = await Hive.openBox("Language");
    return languageBox.get("Language");
  }

  @override
  Future storageLanguage({required String language}) async {
    Box hive = await Hive.openBox("Language");
    await hive.put("Language", language);
  }
}
