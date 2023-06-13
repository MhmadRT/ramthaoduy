import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_drop_down.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/network/api_response_model.dart';
import 'package:ramtha/screens/createaccountscreen/create_account_repository.dart';
import 'package:ramtha/screens/createaccountscreen/models/brigades.dart';
import 'package:ramtha/screens/createaccountscreen/models/cities.dart';
import 'package:ramtha/screens/createaccountscreen/models/create_request.dart';
import 'package:ramtha/screens/createaccountscreen/models/create_response.dart';
import 'package:ramtha/screens/createaccountscreen/models/districts.dart';

import '../../helper/custom/custom_toast_massage.dart';
import '../../helper/local_storage_helper.dart';
import '../mainscreen/main_screen.dart';

class CreateAccountController extends GetxController {
  bool visiblePassword = true;
  bool visiblePasswordConfirm = true;
  TextEditingController userNameFromThreeSection = TextEditingController();
  TextEditingController userNameForRegister = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordConfirm = TextEditingController();
  TextEditingController email = TextEditingController();
  CreateAccountRepository repository = CreateAccountRepository();
  Cities cities = Cities(cities: []);
  Item selectedCity = Item(name: 'أختر المحافظة');
  Districts districts = Districts(districts: []);
  Item selectedDistrict = Item(name: 'أختر المنطقة');
  Brigades brigades = Brigades(brigades: []);
  Item selectedBrigade = Item(name: 'أختر الواء');
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() async {
    // TODO: implement onInit
    Future.delayed(Duration.zero).then((value) => getCities());
    super.onInit();
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
    loading();
    CreateRequest createRequest = CreateRequest(
        name: userNameFromThreeSection.text,
        brigadeId: selectedBrigade.id,
        cityId: selectedCity.id,
        districtId: selectedDistrict.id,
        password: password.text,
        username: userNameForRegister.text,
        deviceToken: 'sfdsfds',
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
