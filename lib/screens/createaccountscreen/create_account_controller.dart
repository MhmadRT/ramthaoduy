import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../helper/custom/custom_toast_massage.dart';

class CreateAccountController extends GetxController {
  bool visiblePassword = true;
  bool visiblePasswordConfirm = true;
  TextEditingController userNameFromThreeSection = TextEditingController();
  TextEditingController userNameForRegister = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController email = TextEditingController();

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

  bool onPressedUnVisibleConfirm() {
    visiblePasswordConfirm = false;
    update();
    return true;
  }

  bool onPressedVisibleConfirm() {
    visiblePasswordConfirm = true;
    update();
    return true;
  }

}
