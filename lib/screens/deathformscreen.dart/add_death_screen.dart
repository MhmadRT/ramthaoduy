import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/helper/custom/custom_text_feild.dart';

import '../../constant/app_images.dart';
import '../../helper/custom/custom_button.dart';
import '../locationscreen/location_screen.dart';
import 'death_controller.dart';

class FormDeathScreen extends StatelessWidget {
  const FormDeathScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<FormDeathController>(
        init: FormDeathController(),
        builder: (controller) {
          return Column(
            children: [
              Wrap(
                runSpacing: 20,
                children: [
                  CustomTextField(
                    controller: controller.nameDeathFromThreeSection,
                    isRequired: true,
                    suffixSvgIconName: "",
                    hintText: "مثال: محمد احمد رمضان",
                    title: "الأسم الثلاثي للشخص المتوفى",
                  ),
                  _buildSelectSex(controller),
                  _buildDate(context, controller),
                  buildRegion(controller),
                  CustomTextField(
                    controller: controller.burial,
                    isRequired: true,
                    suffixSvgIconName: "",
                    maxLines: 5,
                    hintText:
                        "مثال:  وقت الدفن : صلاة الظهر في مسجد خالد بن الوليد",
                    title: "الدفن",
                  ),
                  _buildLocation(context, controller),
                  CustomTextField(
                    controller: controller.theMobileNumberOfTheDeceasedFamily,
                    isRequired: true,
                    suffixSvgIconName: "",
                    inputType: TextInputType.phone,
                    hintText: "+962 789 654 986",
                    title: "رقم موبايل اهل المتوفي",
                  ),
                  CustomTextField(
                    controller: controller.theNameOfTheOwnerOfTheNumber,
                    isRequired: true,
                    suffixSvgIconName: "",
                    hintText: "احمد الحماد",
                    title: "اسم صاحب الرقم",
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              CustomButton(
                color: AppColors.mainColor,
                title: "ارسال",
                borderRadius: 12,
                height: 40,
                width: Get.width - 20,
                colorTitle: AppColors.whiteColor,
                pressed: () {
                  // Get.to(()=> CreateAccountScreen());
                },
              ),
              Visibility(
                visible: MediaQuery.of(context).viewInsets.bottom != 0,
                child: const SizedBox(
                  height: 200,
                ),
              ),
            ],
          );
        });
  }

  Column _buildLocation(BuildContext context, FormDeathController controller) {
    return Column(
      children: [
        Row(
          children: const [
            Text("الموقع",
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: AppColors.editTextColor.withOpacity(.8),
            borderRadius: BorderRadius.circular(18.0),
          ),
          child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              // onPressed: () => _showDateDialog(context, 1, controller),
              onPressed: () {
                Get.to(() => PickLocationScreen(
                      onChanged: (locationInfo) {
                        controller.locationInfo = locationInfo;
                      },
                    ))?.then((value) {
                  controller.update();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.locationInfo.streetInfo ?? "",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w100,
                        color: AppColors.mainColor
                      )),
                  SvgPicture.asset(
                    AppImages.locationIcon,
                    height: 20,
                  )
                ],
              )),
        ),
      ],
    );
  }

  Column buildRegion(FormDeathController controller) {
    return Column(
      children: [
        Row(
          children: const [
            Text("البلدة",
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w500)),
            Text("*",
                style: TextStyle(
                    fontSize: 15,
                    color: Colors.red,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.editTextColor),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: DropdownButton<String>(
                      menuMaxHeight: Get.height / 3,
                      isExpanded: true,
                      icon: SvgPicture.asset(
                        AppImages.dropDownIcon,
                        height: 7,
                      ),
                      focusColor: const Color(0xff00114F),
                      borderRadius: BorderRadius.circular(10),
                      underline: const SizedBox(),
                      value: controller.dropdownValue,
                      iconEnabledColor: Colors.black,
                      dropdownColor: Colors.grey.shade200,
                      items: <String>[
                        'Test1',
                        'Test2',
                        'Test3',
                        'Test4',
                        'Test4',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                        );
                      }).toList(),
                      // Step 5.
                      onChanged: (String? newValue) {
                        // setState(() {
                        //   dropdownValue = newValue!;
                        // });
                      },
                      hint: const Text(
                        "Please choose a langauage",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      )),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Column _buildDate(BuildContext context, FormDeathController controller) {
    return Column(
      children: [
        Row(
          children: const [
            Text("التاريخ",
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.editTextColor.withOpacity(.8),
              borderRadius: BorderRadius.circular(18.0),
              border: Border.all(color: AppColors.mainColor)),
          child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              // onPressed: () => _showDateDialog(context, 1, controller),
              onPressed: () => _showDateDialog(context, controller),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(controller.getFormattedDots(isDotes: true) ?? "",
                      style: const TextStyle(
                          fontSize: 15,
                          color: AppColors.mainColor,
                          fontWeight: FontWeight.w700)),
                ],
              )),
        ),
      ],
    );
  }

  _showDateDialog(
    BuildContext context,
    FormDeathController controller,
  ) {
    var initialTime = DateTime.now();
    initialTime = controller.date;
    FormDeathController.showDatePicker(
        initialTime: initialTime,
        onConfirm: (value) {
          controller.date = value;
          controller.update();
        });
  }

  _buildSelectSex(FormDeathController controller) {
    return Column(
      children: [
        Row(
          children: const [
            Text("الجنس",
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.mainColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                controller.selectSexIndex = 1;
                controller.update();
              },
              child: Container(
                width: Get.width / 2.6,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: controller.selectSexIndex == 1
                        ? AppColors.mainColor
                        : AppColors.editTextColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "ذكر",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: controller.selectSexIndex == 1
                            ? AppColors.whiteColor
                            : AppColors.mainColor),
                  )),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                controller.selectSexIndex = 2;
                controller.update();
              },
              child: Container(
                width: Get.width / 2.6,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: controller.selectSexIndex == 2
                        ? AppColors.mainColor
                        : AppColors.editTextColor),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    "انثى",
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: controller.selectSexIndex == 2
                            ? AppColors.whiteColor
                            : AppColors.mainColor),
                  )),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
