import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/screens/loginscreen/login_repository.dart';
import 'package:ramtha/screens/loginscreen/model/login_request.dart';
import 'package:ramtha/screens/loginscreen/model/login_response.dart';
import 'package:ramtha/screens/mainscreen/main_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../helper/custom/custom_toast_massage.dart';
import '../../helper/local_storage_helper.dart';

class LoginController extends GetxController {
  bool isRememberMe = false;
  bool visiblePassword = true;
  LoginRepository loginRepository = LoginRepository();
  TextEditingController userName = TextEditingController();
  TextEditingController password = TextEditingController();

  login() async {
    if (userName.text.isEmpty) {
      CustomSnackBar.showCustomSnackBar(
        message: 'الرجاء تعبئة البريد الألكتروني',
        backgroundColor: AppColors.blueButtonColor,
        duration: const Duration(seconds: 1),
      );
      return;
    }
    if (password.text.isEmpty) {
      CustomSnackBar.showCustomSnackBar(
        message: 'الرجاء تعبئة كلمة السر',
        backgroundColor: AppColors.blueButtonColor,
        duration: const Duration(seconds: 1),
      );
      return;
    }
    LoginRequest loginRequest = LoginRequest(
        deviceToken: 'sdsdsds',
        password: password.text,
        platform: GetPlatform.isAndroid ? "Android" : "iOS",
        username: userName.text);
    loading();
    await loginRepository.makeLoginAPI(loginRequest.toJson()).then((value) {
      closeLoading();
      if (value is LoginResponse) {
        //save user Data
        //Go To Home
      } else {
        CustomSnackBar.showCustomSnackBar(
          message: value.message,
          backgroundColor: AppColors.blueButtonColor,
          duration: const Duration(seconds: 1),
        );
      }
    });

    if (isRememberMe) {
      LocalStorageHelper.saveCredentials(userName.text, password.text);
    }
  }

  bool onPressedUnVisible() {
    visiblePassword = false;
    update();
    return true;
  }

  bool onPressedVisible() {
    visiblePassword = true;
    update();
    return true;
  }
}
