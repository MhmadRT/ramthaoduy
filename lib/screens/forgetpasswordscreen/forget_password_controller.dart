import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/screens/forgetpasswordscreen/forget_password_repository.dart';
import 'package:ramtha/screens/forgetpasswordscreen/model/forget_password_request.dart';
import 'package:ramtha/screens/forgetpasswordscreen/model/forget_password_response.dart';

import '../../helper/custom/custom_toast_massage.dart';

class ForgetPasswordController extends GetxController {
  TextEditingController emailController = TextEditingController();

  validate() async {
    if (emailController.text.isEmpty) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال البريد الاكتروني",
      );
    }
    if (!GetUtils.isEmail(emailController.text)) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال البريد الاكتروني بشكل صحيح",
      );
    }
    loading();
    ForgetPasswordResponse forgetPasswordResponse =
        await ForgetPasswordRepository().forgetPasswordAPI(
            ForgetPasswordRequest(email: emailController.text).toJson());
    emailController.clear();
    closeLoading();
  }
}
