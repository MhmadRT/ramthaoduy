import 'package:get/get.dart';

import '../../helper/local_storage_helper.dart';
import '../loginscreen/login_screen.dart';
import '../mainscreen/main_screen.dart';

class SplashController extends GetxController {

  @override
  void onInit() async {
    super.onInit();
    await Future.delayed(const Duration(seconds: 1));
    if (await LocalStorageHelper.isRememberMe()) {
      Get.offAll(MainScreen());
    } else {
      Get.offAll(const LoginScreen());
    }
  }
}
