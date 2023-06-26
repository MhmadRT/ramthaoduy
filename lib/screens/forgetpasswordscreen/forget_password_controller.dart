import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../helper/custom/custom_toast_massage.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  bool isValidEmail(String email) {
    const pattern = r'^[\w-]+(\.[\w-]+)*@([a-zA-Z0-9-]+\.)+[a-zA-Z]{2,}$';
    final regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  validate() {
    if (emailController.text.isEmpty) {
      return  CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال البريد الاكتروني",
      );
    }
    if (!isValidEmail(emailController.text)) {
    return  CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال البريد الاكتروني بشكل صحيح",
      );
    }
  }
}
