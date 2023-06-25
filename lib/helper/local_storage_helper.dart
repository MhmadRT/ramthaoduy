import 'dart:convert';
import 'dart:developer';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/loginscreen/model/login_response.dart';
import 'package:ramtha/screens/mainscreen/main_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageHelper {
  static late SharedPreferences pref;
  static var secureStorage = const FlutterSecureStorage();

  static init() async {
    pref = await SharedPreferences.getInstance();
  }

  static Future<void> saveCredentials(
      {required String username,
      required String password,
      required String token}) async {
    await secureStorage.write(key: StorageKeys.userNameKey, value: username);
    await secureStorage.write(key: StorageKeys.passwordKey, value: password);
    await secureStorage.write(key: StorageKeys.token, value: token);
  }

  static Future<void> clearCredentials() async {
    await secureStorage.delete(key: StorageKeys.token);
    await secureStorage.delete(key: StorageKeys.userNameKey);
    await secureStorage.delete(key: StorageKeys.passwordKey);
  }

  static Future<String?> getToken() async {
    return await secureStorage.read(key: StorageKeys.token);
  }

  static Future<bool> isLoggedIn() async {
    String token = await secureStorage.read(key: StorageKeys.token) ?? "";
    String userName =
        await secureStorage.read(key: StorageKeys.userNameKey) ?? "";
    String password =
        await secureStorage.read(key: StorageKeys.passwordKey) ?? "";
    return token.isNotEmpty && userName.isNotEmpty && password.isNotEmpty;
  }

  static saveUserData({LoginResponseData? user}) async {
    await secureStorage.write(
        key: StorageKeys.userData, value: json.encode(user?.toJson()));
  }

  static Future<LoginResponseData?> getUserData() async {
    String? data = await secureStorage.read(key: StorageKeys.userData);
    log(data??"",name: 'User Data');
    LoginResponseData loginResponseData =
        LoginResponseData.fromJson(json.decode((data ?? '{}')));
    return loginResponseData;
  }

  static bool checkRole() {
    if (Get.isRegistered<MainController>()) {
      LoginResponseData? loginResponseData =
          Get.find<MainController>().loginResponseData;
      return loginResponseData?.user?.userRole
              ?.where((element) => element.roleId == 4)
              .isNotEmpty ??
          false;
    } else {
      return false;
    }
  }
}

class StorageKeys {
  static String userNameKey = '1';
  static String userData = '44';
  static String passwordKey = '2';
  static String token = '3';
}
