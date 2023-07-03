import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ramtha/helper/custom/custom_drop_down.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/network/api_response_model.dart';
import 'package:ramtha/screens/createaccountscreen/create_account_repository.dart';
import 'package:ramtha/screens/createaccountscreen/models/brigades.dart';
import 'package:ramtha/screens/createaccountscreen/models/cities.dart';
import 'package:ramtha/screens/createaccountscreen/models/create_request.dart';
import 'package:ramtha/screens/createaccountscreen/models/create_response.dart';
import 'package:ramtha/screens/createaccountscreen/models/districts.dart';
import 'package:ramtha/screens/mainscreen/main_controller.dart';

import '../../helper/custom/custom_toast_massage.dart';
import '../../helper/local_storage_helper.dart';
import '../homescreen/model/get_user_info.dart';
import '../homescreen/model/update_data_request.dart';
import '../mainscreen/main_screen.dart';

class CreateAccountController extends GetxController {
  bool visiblePassword = true;
  bool visiblePasswordConfirm = true;
  late MainController mainController;
  int selectSexIndex = 1;
  TextEditingController userNameFromThreeSection = TextEditingController();
  TextEditingController userNameForRegister = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController editNameController = TextEditingController();
  CreateAccountRepository repository = CreateAccountRepository();

  String lastName = "";
  Cities cities = Cities(cities: []);
  Item selectedCity = Item(name: 'أختر المحافظة',id: '4');
  Districts districts = Districts(districts: []);
  Item selectedDistrict = Item(name: 'أختر المنطقة');
  Brigades brigades = Brigades(brigades: []);
  Item selectedBrigade = Item(name: 'أختر الواء',id: '2');
  final formKey = GlobalKey<FormState>();

  XFile? imagePath;

  @override
  void onInit() async {
    // TODO: implement onInit

    if (Get.isRegistered<MainController>()) {
      mainController = Get.find<MainController>();
      editNameController.text =
          mainController.userInfoResponse?.data?.user?.name ?? "";
      update();
    }
    Future.delayed(Duration.zero).then((value) => getDistrict());
    super.onInit();
  }

  bool hasThreeSpaces(String text) {
    int spaceCount = 0;
    String newText = text.trim().replaceAll("  ", "");
    for (int i = 0; i < newText.length; i++) {
      if (newText[i] == ' ') {
        spaceCount++;
      }

      if (spaceCount >= 2) {
        return true;
      }
    }

    return false;
  }

  updateUserInfo() async {
    loading();
    UpdateRequest updateRequest = UpdateRequest(
      name: editNameController.text,
      image: imagePath?.path,
      brigadeId: selectedBrigade.id,
      cityId: selectedCity.id,
      districtId: selectedDistrict.id,
      email: email.text,
    );
    ApiResponseModel apiResponseModel = await repository.updateUserInfo(
        body: updateRequest.toJson(), file: imagePath);
    closeLoading();
    if (apiResponseModel.status != '1') {
      CustomSnackBar.showCustomSnackBar(
        message: apiResponseModel.message,
      );
    } else {
      Get.back();
      await Get.find<MainController>().getUserData();
    }
    update();
  }

  getCities() async {
    loading();
    selectedCity = Item(name: 'أختر المحافظة');
    selectedBrigade = Item(name: 'أختر الواء');
    selectedDistrict = Item(name: 'أختر المنطقة');
    cities = Cities(cities: []);
    cities = await repository.getCities();
    update();
    closeLoading();
  }

  getBrigades() async {
    loading();
    selectedBrigade = Item(name: 'أختر الواء');
    selectedDistrict = Item(name: 'أختر المنطقة');
    brigades = Brigades(brigades: []);
    brigades = await repository.getBrigades(cityId: selectedCity.id ?? "");
    update();
    closeLoading();
  }

  getDistrict() async {
    loading();
    selectedDistrict = Item(name: 'أختر المنطقة');
    districts = Districts(districts: []);
    districts =
        await repository.getDistricts(brigadeId: selectedBrigade.id ?? "");
    update();
    closeLoading();
  }

  makeRegister() async {
    if (selectedCity.id == null) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء اختيار المحافظة",
      );
    }
    if (selectedBrigade.id == null) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء اختيار اللواء",
      );
    }
    if (selectedDistrict.id == null) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء اختيار المنطقة",
      );
    }
    loading();
    CreateRequest createRequest = CreateRequest(
        name: userNameFromThreeSection.text,
        brigadeId: selectedBrigade.id,
        cityId: selectedCity.id,
        districtId: selectedDistrict.id,
        email: email.text,
        password: password.text,
        username: userNameForRegister.text,
        deviceToken: 'sfdsfds',
        gender: selectSexIndex == 1 ? "1" : "2",
        platform: GetPlatform.isAndroid ? "android" : 'ios');
    CreateResponse createResponse =
        await repository.createAccountAPI(createRequest.toJson());
    closeLoading();
    if (createResponse.status == '1') {
      await LocalStorageHelper.saveCredentials(
          username: userNameForRegister.text,
          password: password.text,
          token: createResponse.data?.token ?? "");
      Get.offAll(MainScreen());
    } else {
      CustomSnackBar.showCustomSnackBar(
        message: createResponse.message,
      );
    }
  }
}
