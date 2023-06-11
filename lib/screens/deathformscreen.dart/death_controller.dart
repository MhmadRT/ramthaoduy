import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/flutter_rounded_date_picker.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ramtha/constant/app_colors.dart';
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

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
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
