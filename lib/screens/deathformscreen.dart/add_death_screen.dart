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
                    hintText: "مثال: محمد احمد مراد رمضان",
                    title: "الأسم الرباعي للشخص المتوفى",
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
                                      if (controller.imagePath == null) {
                                        ImagePicker()
                                            .pickImage(
                                                source: ImageSource.gallery)
                                            .then((value) {
                                          if (value != null) {
                                            controller.imagePath = value;
                                          }
                                          controller.update();
                                        });
                                      } else {
                                        controller.imagePath = null;
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
                    initialTime: controller.date,
                    label: 'تاريخ الوفاه',
                    onConfirm: (v) {
                      controller.date = v;
                      controller.update();
                    },
                    required: true,
                  ),
                  CustomDropdown(
                      isRequired: true,
                      label: 'المنطقة',
                      listItems: controller.districts.districts ?? [],
                      selectedItem: controller.selectedDistrict,
                      onSelected: (v) {
                        controller.selectedDistrict = v;
                        controller.update();
                      }),
                  Column(
                    children: [
                      const Row(
                        children: [
                          Text(
                            "صورة الهوية لمقدم النعي",
                            style: TextStyle(
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w500),
                          ),
                          Text(
                            "*",
                            style: TextStyle(
                                color: AppColors.red,
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Stack(
                              children: [
                                Container(
                                  width: Get.width,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      color: AppColors.editTextColor),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(children: [
                                      if (controller.imageCard?.path == null)
                                        const Expanded(child: Text("")),
                                      if (controller.imageCard?.path != null)
                                        Expanded(
                                            child: Row(
                                          children: [
                                            if (controller.imageCard?.path !=
                                                null)
                                              Text(controller.imageCard!.path
                                                  .toString()
                                                  .substring(80)),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            InkWell(
                                              onTap: () {
                                                controller.imageCard = null;
                                                controller.update();
                                              },
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                    color: AppColors.red,
                                                    shape: BoxShape.circle),
                                                child: const Padding(
                                                  padding: EdgeInsets.all(2.0),
                                                  child: Icon(Icons.close,
                                                      color:
                                                          AppColors.whiteColor,
                                                      size: 15),
                                                ),
                                              ),
                                            )
                                          ],
                                        )),
                                      InkWell(
                                        onTap: () {
                                          controller.imgFromGallery();
                                        },
                                        child: const Icon(Icons.image,
                                            color: Colors.grey),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      InkWell(
                                        child: const Icon(
                                            Icons.camera_alt_outlined,
                                            color: Colors.grey),
                                        onTap: () {
                                          controller.imgFromCamera();
                                        },
                                      ),
                                    ]),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(
                                    "سنقوم بازالة صورة الهوية من الخادم حال مرور 30 يوم على نشر النعي",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.withOpacity(.8),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      CustomDropdown(
                          isRequired: true,
                          label: 'صلة قرابة الناشر بالمتوفي',
                          listItems: controller.relationship.relationship ?? [],
                          selectedItem: controller.selectedDegreeOfKinship,
                          onSelected: (v) {
                            controller.selectedDegreeOfKinship = v;
                            controller.update();
                          }),
                      const SizedBox(height: 5,),
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                const Text(
                                  "*",
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                ),
                                Expanded(
                                  child: Text(
                                    "يجب ان يكون المتوفى ضمن احد الخيارات المذكورين في قائمة صلة القرابة",
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.grey.withOpacity(.8),
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  CustomTextField(
                    controller: controller.burial,
                    isRequired: true,
                    suffixSvgIconName: "",
                    maxLines: 5,
                    hintText:
                        "لاحول ولا قوة إلا بالله، إنا لله وإنا إليه راجعون، لله ما أخذ ولله ما أعطى وكل شيء عنده بمقدار/ وقت الدفن عند صلاة الظهر في مسجد خالد بن الوليد",
                    title: "النعي/وتفاصيل الدفن",
                  ),
                  _buildLocation(context, controller),
                  _buildCondolencesMaleLocation(context, controller),
                  _buildCondolencesFemaleLocation(context, controller),
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
            Text("موقع الدفن",
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

  Column _buildCondolencesMaleLocation(
      BuildContext context, FormDeathController controller) {
    return Column(
      children: [
        const Row(
          children: [
            Text("موقع عزاء الرجال",
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
                        controller.locationCondolencesMaleInfo = locationInfo;
                      },
                    ))?.then((value) {
                  controller.update();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(controller.locationCondolencesMaleInfo.streetInfo ?? "",
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

  Column _buildCondolencesFemaleLocation(
      BuildContext context, FormDeathController controller) {
    return Column(
      children: [
        const Row(
          children: [
            Text("موقع عزاء النساء",
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
                        controller.locationCondolencesFeMaleInfo = locationInfo;
                      },
                    ))?.then((value) {
                  controller.update();
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                      controller.locationCondolencesFeMaleInfo.streetInfo ?? "",
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

  _buildSelectSex(FormDeathController controller) {
    return Column(
      children: [
        Row(
          children: [
            Text(
                controller.selectSexIndex == 1 ? "جنس المتوفي" : "جنس المتوفية",
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
