import 'package:get/get.dart';

import '../../helper/local_storage_helper.dart';
import '../loginscreen/login_screen.dart';
import '../mainscreen/main_screen.dart';

class SplashController extends GetxController {
  UserModel? userModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    Future.delayed(const Duration(milliseconds: 3000), () async {
      userModel = LocalStorageHelper.getCredentials();

      if ((userModel?.email.isEmpty ?? true) &&
          (userModel?.password.isEmpty ?? true)) {
        Get.offAll(const LoginScreen());
      } else {
        Get.offAll(  MainScreen());
      }
    });
  }
}
