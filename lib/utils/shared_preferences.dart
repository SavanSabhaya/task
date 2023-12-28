import 'package:get_storage/get_storage.dart';
import 'package:task/common/constants/storage_key_constants.dart';

class SharePref {
  static late final GetStorage pref;

  SharePref init() {
    GetStorage.init(StorageKeyConstants.cDataStore);
    pref = GetStorage(StorageKeyConstants.cDataStore);
    return this;
  }

  void saveIsLogin(bool isLogin) {
    pref.write(StorageKeyConstants.cKeyIsLogin, isLogin);
  }

   void saveToken(String token) {
    pref.write(StorageKeyConstants.cKeyIsToken, token);
  }

  String getToken() {
    return pref.read(StorageKeyConstants.cKeyIsToken);
  }

  bool getIsLogin() {
    if (pref.read(StorageKeyConstants.cKeyIsLogin) != null) {
      return pref.read(StorageKeyConstants.cKeyIsLogin);
    } else {
      return false;
    }
  }
}
