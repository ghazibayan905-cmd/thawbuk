import 'package:e_commerce/core/enums/data_type.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesRepository {
  SharedPreferences globalSharedPreferences = Get.find();
  //!--- Keys ----
  String tokenKey = 'token';


  bool get isLoggedIn => getToken() != null ? true : false;

  void setToken(String value) {
    setPreference(dataType: DataType.STRING, key: tokenKey, value: value);
  }

  String? getToken() {
    if (globalSharedPreferences.containsKey(tokenKey)) {
      return getPreference(key: tokenKey);
    } else {
      return null;
    }
  }

  void clearStorage() {
    globalSharedPreferences.clear();
  }

  //?--
  //!--- Main Function ----
  setPreference({
    required DataType dataType,
    required String key,
    required dynamic value,
  }) async {
    switch (dataType) {
      case DataType.INT:
        await globalSharedPreferences.setInt(key, value);
        break;
      case DataType.BOOL:
        await globalSharedPreferences.setBool(key, value);
        break;
      case DataType.DOUBLE:
        await globalSharedPreferences.setDouble(key, value);
        break;
      case DataType.STRING:
        await globalSharedPreferences.setString(key, value);
        break;
      case DataType.STRINGLIST:
        await globalSharedPreferences.setStringList(key, value);
        break;
      default:
        break;
    }
  }

  getPreference({required String key}) {
    return globalSharedPreferences.get(key);
  }
}
