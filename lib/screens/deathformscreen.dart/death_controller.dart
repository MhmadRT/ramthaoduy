import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ramtha/constant/app_colors.dart';
import '../../helper/custom/custom_drop_down.dart';
import '../../helper/custom/custom_loading.dart';
import '../createaccountscreen/create_account_repository.dart';
import '../createaccountscreen/models/brigades.dart';
import '../createaccountscreen/models/cities.dart';
import '../createaccountscreen/models/districts.dart';
import '../locationscreen/location_screen.dart';

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

  LocationInfo locationInfo=LocationInfo(streetInfo: "موقع المقبرة");

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
