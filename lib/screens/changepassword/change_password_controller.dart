import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/custom_toast_massage.dart';
import '../../network/api_response_model.dart';
import '../createaccountscreen/create_account_repository.dart';
import '../homescreen/model/update_data_request.dart';
import '../mainscreen/main_controller.dart';

class ChangePasswordController extends GetxController {
  TextEditingController oldPassword = TextEditingController();
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmPassword = TextEditingController();
  CreateAccountRepository repository = CreateAccountRepository();
  final formKey = GlobalKey<FormState>();

  bool visiblePassword = false;
  bool oldVisiblePassword = false;

  bool visiblePasswordConfirm = false;

  changePassword() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    String name = '';
    if (Get.isRegistered<MainController>()) {
      var mainController = Get.find<MainController>();
      name = mainController.userInfoResponse?.data?.user?.name ?? "";
      update();
    }
    loading();
    UpdateRequest updateRequest = UpdateRequest(
        name: name,
        newPassword: confirmPassword.text,
        oldPassword: oldPassword.text);
    ApiResponseModel apiResponseModel =
        await repository.updateUserInfo(body: updateRequest.toJson());
    closeLoading();
    if (apiResponseModel.status != '1') {
      CustomSnackBar.showCustomSnackBar(
        message: apiResponseModel.message,
      );
    } else {
      Get.back();
      CustomSnackBar.showCustomSnackBar(
        message: apiResponseModel.message,
      );
    }
    update();
  }
}
