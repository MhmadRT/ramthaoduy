import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/helper/custom/custom_text_feild.dart';

import '../../constant/app_images.dart';
import '../../helper/custom/custom_button.dart';
import '../../helper/custom/custom_date_picker.dart';
import '../../helper/custom/custom_drop_down.dart';
import '../../helper/custom/user_image.dart';
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
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            controller.selectSexIndex == 1
                                ? "صورة المتوفي"
                                : "صورة المتوفية",
                            style: TextStyle(color: AppColors.mainColor),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                controller.imagePath == null
                                    ? Container(
                                        width: Get.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          color: AppColors.mainColor
                                              .withOpacity(.2),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: UserImage(
                                              userImage: "",
                                              gender:
                                                  controller.selectSexIndex == 1
                                                      ? "ذكر"
                                                      : "انثى",
                                              radius: 0,
                                              boxFit: BoxFit.cover,
                                              size: 200),
                                        ),
                                      )
                                    : ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: SizedBox(
                                            height: Get.height / 3.8,
                                            width: Get.width,
                                            child: Image.file(
                                              File(controller.imagePath!.path),
                                              fit: BoxFit.cover,
                                            ))),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  right: 0,
                                  child: InkWell(
                                    onTap: () {
                                      if(controller.imagePath == null){
                                        ImagePicker()
                                            .pickImage(
                                            source: ImageSource.gallery)
                                            .then((value) {
                                          if (value != null) {
                                            controller.imagePath = value;
                                          }
                                          controller.update();
                                        });
                                      }else{
                                        controller.imagePath=null;
                                        controller.update();
                                      }

                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: AppColors.mainColor
                                              .withOpacity(.8),
                                          borderRadius: const BorderRadius.only(
                                            bottomRight: Radius.circular(15),
                                            bottomLeft: Radius.circular(15),
                                          )),
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Text(
                                            controller.imagePath == null
                                                ? "اختر صورة"
                                                : "حذف الصورة",
                                            textAlign: TextAlign.center,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.whiteColor)),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  CustomDateField(
                    label: 'تاريخ الوفاه',
                    onConfirm: (v) {
                      controller.date = v;
                      controller.update();
                    },
                    required: true,
                  ),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // CustomDropdown(
                  //     listItems: controller.cities.cities ?? [],
                  //     selectedItem: controller.selectedCity,
                  //     isRequired: true,
                  //     label: 'المحافظة',
                  //     onSelected: (v) {
                  //       controller.selectedCity = v;
                  //       if (v.name != "") {
                  //         controller.selectedCity.isSelected = true;
                  //       } else {
                  //         controller.selectedCity.isSelected = false;
                  //       }
                  //       controller.update();
                  //       controller.getBrigades();
                  //     }),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  // CustomDropdown(
                  //     isRequired: false,
                  //     label: 'الواء',
                  //     listItems: controller.brigades.brigades ?? [],
                  //     selectedItem: controller.selectedBrigade,
                  //     onSelected: (v) {
                  //       controller.selectedBrigade = v;
                  //       controller.update();
                  //       controller.getDistrict();
                  //     }),
                  // const SizedBox(
                  //   height: 10,
                  // ),
                  CustomDropdown(
                      isRequired: false,
                      label: 'المنطقة',
                      listItems: controller.districts.districts ?? [],
                      selectedItem: controller.selectedDistrict,
                      onSelected: (v) {
                        controller.selectedDistrict = v;
                        controller.update();
                      }),
                  const SizedBox(
                    height: 40,
                  ),
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
                  controller.validateForm();
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
        const Row(
          children: [
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
                          color: AppColors.mainColor)),
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

  Column _buildDate(BuildContext context, FormDeathController controller) {
    return Column(
      children: [
        const Row(
          children: [
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
          children: [
            Text(controller.selectSexIndex==1?"الجنس المتوفي":"جنس المتوفية",
                style: const TextStyle(
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
