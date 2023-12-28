import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kisan_facility/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

final storageSharedPrefProvider = Provider((ref) => StorageHelper());

class StorageKeys {
  static const String token = "TOKEN";
  static const String userData = "USER";
  static const String loggedIn = "LOGGED_IN";
  static const String introShowed = "INTRO_SHOWED";
}

class StorageHelper {
  static SharedPreferences? storageBox;
  static Future<dynamic> _getInstance() async =>
      storageBox = await SharedPreferences.getInstance();

  static Future<bool> getBoolIn(String key) async {
    await _getInstance();
    return storageBox?.getBool(key) ?? false;
  }

  static void setBoolIn(String key, dynamic value) async {
    await _getInstance();
    await storageBox!.setBool(key, value);
  }

  static Future<String> getStringIn(String key) async {
    await _getInstance();
    return storageBox?.getString(key) ?? "";
  }

  static void setStringIn(String key, dynamic value) async {
    await _getInstance();
    await storageBox!.setString(key, value);
  }

  static void setLoggedUser(UserModel value) async {
    await _getInstance();
    await storageBox!.setString(StorageKeys.userData, jsonEncode(value));
  }

  Future<UserModel?> getLoggedUser() async {
    await _getInstance();
    var str = storageBox?.getString(StorageKeys.userData);
    return str != null ? UserModel.fromJson(jsonDecode(str)) : null;
  }

  static void remove(String key) async {
    await _getInstance();
    storageBox?.remove(key);
  }
}
