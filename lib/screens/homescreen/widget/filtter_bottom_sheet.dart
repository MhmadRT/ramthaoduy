import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_button.dart';
import 'package:ramtha/screens/homescreen/home_conrtoller.dart';

import '../../../constant/app_colors.dart';
import '../../../helper/custom/custom_date_picker.dart';
import '../../../helper/custom/custom_drop_down.dart';

class FilterBottomSheet extends StatelessWidget {
  const FilterBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Container(
              height: Get.height / 1.2,
              decoration: const BoxDecoration(
                  color: AppColors.whiteColor,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25))),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100,
                          height: 5,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(20)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Wrap(
                          runSpacing: 20,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.allPost = !controller.allPost;

                                      if (controller.isVisibleGender ||
                                          controller.isVisibleDate ||
                                          controller.isVisibleDrop) {
                                        controller.allPost = false;
                                      }
                                      controller.update();
                                    },
                                    child: Row(
                                      children: [
                                        AnimatedSwitcher(
                                          duration:
                                          const Duration(milliseconds: 300),
                                          child: controller.allPost
                                              ? const Icon(
                                              Icons.check_box_outlined,
                                              color: AppColors.mainColor)
                                              : const Icon(
                                              Icons
                                                  .check_box_outline_blank_outlined,
                                              color: AppColors.mainColor),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "الكل",
                                          style: TextStyle(
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.isVisibleDate =
                                      !controller.isVisibleDate;
                                      if (controller.isVisibleGender ||
                                          controller.isVisibleDate ||
                                          controller.isVisibleDrop) {
                                        controller.allPost = false;
                                      }
                                      controller.update();
                                    },
                                    child: Row(
                                      children: [
                                        AnimatedSwitcher(
                                          duration:
                                          const Duration(milliseconds: 300),
                                          child: controller.isVisibleDate
                                              ? const Icon(
                                              Icons.check_box_outlined,
                                              color: AppColors.mainColor)
                                              : const Icon(
                                              Icons
                                                  .check_box_outline_blank_outlined,
                                              color: AppColors.mainColor),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "التاريخ",
                                          style: TextStyle(
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: controller.isVisibleDate,
                              child: Column(
                                children: [
                                  CustomDateField(
                                    label: 'من تاريخ',
                                    onConfirm: (v) {
                                      controller.fromDate = v;
                                      controller.update();
                                    },
                                    required: false,
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  CustomDateField(
                                    label: 'الى تاريخ',
                                    onConfirm: (v) {
                                      controller.fromDate = v;
                                      controller.update();
                                    },
                                    required: false,
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.isVisibleGender =
                                      !controller.isVisibleGender;
                                      if (controller.isVisibleGender ||
                                          controller.isVisibleDate ||
                                          controller.isVisibleDrop) {
                                        controller.allPost = false;
                                      }
                                      controller.update();
                                    },
                                    child: Row(
                                      children: [
                                        AnimatedSwitcher(
                                          duration:
                                          const Duration(milliseconds: 300),
                                          child: controller.isVisibleGender
                                              ? const Icon(
                                              Icons.check_box_outlined,
                                              color: AppColors.mainColor)
                                              : const Icon(
                                              Icons
                                                  .check_box_outline_blank_outlined,
                                              color: AppColors.mainColor),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "الجنس",
                                          style: TextStyle(
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: controller.isVisibleGender,
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
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
                                          borderRadius:
                                          BorderRadius.circular(15),
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
                                                  color:
                                                  controller.selectSexIndex == 1
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
                                          borderRadius:
                                          BorderRadius.circular(15),
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
                                                  color:
                                                  controller.selectSexIndex == 2
                                                      ? AppColors.whiteColor
                                                      : AppColors.mainColor),
                                            )),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.isVisibleDrop =
                                      !controller.isVisibleDrop;
                                      if (controller.isVisibleDrop) {
                                        controller.getCities();
                                      }
                                      if (controller.isVisibleGender ||
                                          controller.isVisibleDate ||
                                          controller.isVisibleDrop) {
                                        controller.allPost = false;
                                      }
                                      controller.update();
                                    },
                                    child: Row(
                                      children: [
                                        AnimatedSwitcher(
                                          duration:
                                          const Duration(milliseconds: 300),
                                          child: controller.isVisibleDrop
                                              ? const Icon(
                                              Icons.check_box_outlined,
                                              color: AppColors.mainColor)
                                              : const Icon(
                                              Icons
                                                  .check_box_outline_blank_outlined,
                                              color: AppColors.mainColor),
                                        ),
                                        const SizedBox(
                                          width: 5,
                                        ),
                                        const Text(
                                          "المناطق",
                                          style: TextStyle(
                                            color: AppColors.mainColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Visibility(
                              visible: controller.isVisibleDrop,
                              child: Wrap(
                                runSpacing: 20,
                                children: [
                                  CustomDropdown(
                                      listItems: controller.cities.cities ?? [],
                                      selectedItem: controller.selectedCity,
                                      isRequired: true,
                                      label: 'المحافظة',
                                      onSelected: (v) {
                                        controller.selectedCity = v;
                                        controller.update();
                                        controller.getBrigades();
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomDropdown(
                                      isRequired: true,
                                      label: 'الواء',
                                      listItems:
                                      controller.brigades.brigades ?? [],
                                      selectedItem: controller.selectedBrigade,
                                      onSelected: (v) {
                                        controller.selectedBrigade = v;
                                        controller.update();
                                        controller.getDistrict();
                                      }),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  CustomDropdown(
                                      isRequired: true,
                                      label: 'المنطقة',
                                      listItems:
                                      controller.districts.districts ?? [],
                                      selectedItem: controller.selectedDistrict,
                                      onSelected: (v) {
                                        controller.selectedDistrict = v;
                                        controller.update();
                                      }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 100, vertical: 20),
                            child: CustomButton(
                              color:controller.isVisibleDrop ||
                                  controller.allPost ||
                                  controller.isVisibleGender ||
                                  controller.isVisibleDate? AppColors.mainColor:AppColors.mainColor.withOpacity(.5),
                              title: "بحث",
                              colorTitle: AppColors.whiteColor,
                              pressed: controller.isVisibleDrop ||
                                  controller.allPost ||
                                  controller.isVisibleGender ||
                                  controller.isVisibleDate ? () {
                                controller.getPosts();
                                Get.back();
                              }:(){},
                              height: 40,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
        });
  }
}
