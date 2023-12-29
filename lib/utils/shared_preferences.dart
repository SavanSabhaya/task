import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/reponseModel/login_model.dart';

class MySharedPref {
  static MySharedPref? classInstance;
  static SharedPreferences? preferences;

  static Future<MySharedPref> getInstance() async {
    classInstance ??= MySharedPref();
    preferences ??= await SharedPreferences.getInstance();
    return classInstance!;
  }

  Future<void> setString(String key, String content) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Value Set ::::::$content");
    prefs.setString(key, content);
  }

  Future<void> setBool(String key, bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print("Value set ::::::$value");
    prefs.setBool(key, value);
  }

  getStringValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    String stringValue = prefs.getString(key) ?? "";
    print("Value set ::::::$stringValue");
    return stringValue;
  }

  getBoolValue(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return String
    bool? boolVal = prefs.getBool(key);
    print("Value get ::::::$boolVal");
    return boolVal;
  }


  setLoginModel(model, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(key, json.encode(model.toJson()));
  }

  Future<LoginModel?> getLoginModel(String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var myJson = prefs.getString(key);
    if (myJson == null) {
      return null;
    }
    return LoginModel.fromJson(json.decode(myJson));
  }
}
