import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../helper/custom/custom_drop_down.dart';
import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/custom_sucsess_dialog.dart';
import '../../helper/custom/custom_toast_massage.dart';
import '../../network/api_response_model.dart';
import '../createaccountscreen/create_account_repository.dart';
import '../createaccountscreen/models/brigades.dart';
import '../createaccountscreen/models/cities.dart';
import '../createaccountscreen/models/degree_of_kinship_model.dart';
import '../createaccountscreen/models/districts.dart';
import '../locationscreen/location_screen.dart';
import '../mainscreen/main_controller.dart';
import 'death_form_repository.dart';
import 'model/death_form_request.dart';

class FormDeathController extends GetxController {
  int selectSexIndex = 1;
  TextEditingController nameDeathFromThreeSection = TextEditingController();
  TextEditingController burial = TextEditingController();
  TextEditingController theMobileNumberOfTheDeceasedFamily =
      TextEditingController();
  TextEditingController theNameOfTheOwnerOfTheNumber = TextEditingController();
  DateTime date = DateTime.now();
  var formatter = DateFormat('dd/MM/yyyy');
  var formatterDots = DateFormat('dd.MM.yyyy');
  String dropdownValue = 'Test1';

  LocationInfo locationInfo = LocationInfo(streetInfo: "موقع المقبرة");
  LocationInfo locationCondolencesMaleInfo =
      LocationInfo(streetInfo: "موقع عزاء الرجال");
  LocationInfo locationCondolencesFeMaleInfo =
      LocationInfo(streetInfo: "موقع عزاء النساء");

  CreateAccountRepository repository = CreateAccountRepository();
  DeathFormRepository deathFormRepository = DeathFormRepository();
  Cities cities = Cities(cities: []);
  Item selectedCity = Item(
    name: 'أختر المحافظة',
    id: '1',
  );
  Districts districts = Districts(districts: []);
  Relationship relationship = Relationship(relationship: []);
  Item selectedDistrict = Item(name: 'أختر المنطقة');
  Item selectedDegreeOfKinship = Item(name: 'أختر درجة القرابة');
  Brigades brigades = Brigades(brigades: []);
  Item selectedBrigade = Item(name: 'أختر الواء', id: '1');
  final formKey = GlobalKey<FormState>();
  XFile? imagePath;
  late ImagePicker imagePicker;
  File? imageCard;
  ScrollController scrollController = ScrollController();

  @override
  void onInit() async {
    imagePicker = ImagePicker();
    // TODO: implement onInit
    Future.delayed(Duration.zero).then((value) => getDistrict());
    Future.delayed(Duration.zero).then((value) => getDegreeOfKinship());

    super.onInit();
  }

  imgFromCamera() async {
    XFile? pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageCard = File(pickedFile.path);
    }
    update();
  }

  imgFromGallery() async {
    XFile? pickedFile =
        await imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageCard = File(pickedFile.path);
    }
    update();
  }

  bool hasThreeSpaces(String text) {
    int spaceCount = 0;
    String newText = text.trim().replaceAll("  ", "");
    for (int i = 0; i < newText.length; i++) {
      if (newText[i] == ' ') {
        spaceCount++;
      }

      if (spaceCount >= 3) {
        return true;
      }
    }

    return false;
  }

  validateForm() {
    if (nameDeathFromThreeSection.text.isEmpty) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال اسم المتوفي/ة",
      );
    }
    if (!hasThreeSpaces(nameDeathFromThreeSection.text)) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال اسم المتوفي/ة من اربع مقاطع",
      );
    }
    if (date.isAfter(DateTime.now())) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء اختيار تاريخ صحيح",
      );
    }
    if (selectedDistrict.id == null) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء اختيار المنطقة",
      );
    }
    if (imageCard == null) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال صورة هوية مقدم النعي",
      );
    }
    if (burial.text.isEmpty) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء تعبئة النعي/وتفاصيل الدفن",
      );
    }
    // if (locationInfo.lng == null || locationInfo.lng == null) {
    //   return CustomSnackBar.showCustomSnackBar(
    //     message: "الرجاء ادخال موقع الدفن",
    //   );
    // }
    if (theMobileNumberOfTheDeceasedFamily.text.isEmpty) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال رقم الهاتف لاهل المتوفي/ة",
      );
    }
    if (theNameOfTheOwnerOfTheNumber.text.isEmpty) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء اسم صاحب الرقم",
      );
    }
    addDeath();
  }

  addDeath() async {
    MainController mainController = Get.find<MainController>();
    loading();
    AddDeathsRequest addDeathsRequest = AddDeathsRequest(
      cityId: selectedDistrict.id,
      relationship: selectedDegreeOfKinship.id,
      phoneNumber: theMobileNumberOfTheDeceasedFamily.text,
      longitude: locationInfo.lat.toString() ?? "",
      latatude: locationInfo.lng.toString() ?? "",
      latatudeCondolencesFeMaleInfo:
          locationCondolencesFeMaleInfo.lat.toString() ?? "",
      longitudeCondolencesFeMaleInfo:
          locationCondolencesFeMaleInfo.lng.toString() ?? "",
      longitudeCondolencesMaleInfo:
          locationCondolencesMaleInfo.lng.toString() ?? "",
      latatudeCondolencesMaleInfo:
          locationCondolencesMaleInfo.lat.toString() ?? "",
      birthDate: date.toIso8601String(),
      buryDescription: burial.text,
      deadName: nameDeathFromThreeSection.text,
      gender: selectSexIndex == 1 ? "1" : "0",
      nameOfRequester: mainController.userInfoResponse?.data?.user?.name,
      description: burial.text,
    );
    //

    var body = addDeathsRequest.toJson();
    if (locationInfo.lng == null) {
      body.remove("longitude");
      body.remove("latatude");
    }
    if (locationCondolencesMaleInfo.lng == null) {
      body.remove("latatudeCondolencesMaleInfo");
      body.remove("longitudeCondolencesMaleInfo");
    }
    if (locationCondolencesFeMaleInfo.lng == null) {
      body.remove("latatudeCondolencesFeMaleInfo");
      body.remove("longitudeCondolencesFeMaleInfo");
    }

    // print(body);
    ApiResponseModel apiResponseModel = await deathFormRepository.addDeaths(
        body, imagePath, XFile(imageCard!.path));

    closeLoading();

    Get.dialog(SuccessDialog(
      massage: apiResponseModel.status == "1"
          ? " تم القبول ${apiResponseModel.message}"
          : " تم الرفض ${apiResponseModel.message}",
    ));
    if (apiResponseModel.status == '1') {
      mainController.currentIndex = 2;
      mainController.update();
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

  getDegreeOfKinship() async {
    loading();
    selectedDegreeOfKinship = Item(name: 'أختر درجة القرابة');
    relationship = Relationship(relationship: []);
    relationship = await repository.getDegreeOfKinship();
    update();
    closeLoading();
  }

  getFormattedDots({bool? isDotes}) {
    if (isDotes == true) {
      return formatterDots.format(date);
    } else {
      return formatter.format(date);
    }
  }
}
