import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/screens/homescreen/home_conrtoller.dart';
import '../../helper/custom/custom_drop_down.dart';
import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/custom_sucsess_dialog.dart';
import '../../helper/custom/custom_toast_massage.dart';
import '../../network/api_response_model.dart';
import '../createaccountscreen/create_account_repository.dart';
import '../createaccountscreen/models/brigades.dart';
import '../createaccountscreen/models/cities.dart';
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

  CreateAccountRepository repository = CreateAccountRepository();
  DeathFormRepository deathFormRepository = DeathFormRepository();
  Cities cities = Cities(cities: []);
  Item selectedCity = Item(
    name: 'أختر المحافظة',
    id: '4',
  );
  Districts districts = Districts(districts: []);
  Item selectedDistrict = Item(name: 'أختر المنطقة');
  Brigades brigades = Brigades(brigades: []);
  Item selectedBrigade = Item(name: 'أختر الواء', id: '2');
  final formKey = GlobalKey<FormState>();
  XFile? imagePath;

  @override
  void onInit() async {
    // TODO: implement onInit
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

  validateForm() {
    if (nameDeathFromThreeSection.text.isEmpty) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال اسم المتوفي/ة",
      );
    }
    if (!hasThreeSpaces(nameDeathFromThreeSection.text)) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال اسم المتوفي/ة من ثلاث مقاطع",
      );
    }
    if (date.isAfter(DateTime.now())) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء اختيار تاريخ صحيح",
      );
    }
    if (selectedDistrict.id == null) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء اختيار المحافظة",
      );
    }

    if (locationInfo.lng == null || locationInfo.lng == null) {
      return CustomSnackBar.showCustomSnackBar(
        message: "الرجاء ادخال موقع الدفن",
      );
    }
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
      cityId: selectedCity.id,
      phoneNumber: theMobileNumberOfTheDeceasedFamily.text,
      longitude: locationInfo.lat.toString(),
      latatude: locationInfo.lng.toString(),
      birthDate: date.toIso8601String(),
      buryDescription: burial.text,
      deadName: nameDeathFromThreeSection.text,
      gender: selectSexIndex == 1 ? "1" : "0",
      nameOfRequester: mainController.userInfoResponse?.data?.user?.name,
      description: burial.text,
    );
    ApiResponseModel apiResponseModel = await deathFormRepository.addDeaths(
        addDeathsRequest.toJson(), imagePath);
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

  getFormattedDots({bool? isDotes}) {
    if (isDotes == true) {
      return formatterDots.format(date);
    } else {
      return formatter.format(date);
    }
  }

  static void showDatePicker(
      {DateTime? initialTime, ValueChanged<DateTime>? onConfirm}) {
    showRoundedDatePicker(
      textPositiveButton: "موافق",
      textNegativeButton: "الغاء",
      height: 250,
      context: Get.context!,
      initialDate: initialTime,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 100),
      borderRadius: 16,
      theme: ThemeData(
        primaryColor: AppColors.mainColor,
      ),
      styleYearPicker: MaterialRoundedYearPickerStyle(),
      builderDay: (dateTime, isCurrentDay, selected, defaultTextStyle) =>
          Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.mainColor : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            // DateFormat.d(Get.locale?.languageCode == 'ar' ? 'ar_SA' : 'en_USA')
            //     .format(dateTime),
            DateFormat.d(
                    Get.locale?.languageCode == 'en_USA' ? 'en_USA' : 'en_USA')
                .format(dateTime),
            style: defaultTextStyle.copyWith(
              color: selected
                  ? AppColors.whiteColor
                  : isCurrentDay
                      ? AppColors.mainColor
                      : Colors.black,
            ),
          ),
        ),
      ),
    ).then((value) {
      if (value != null) {
        onConfirm?.call(value);
      }
    });
  }
}
