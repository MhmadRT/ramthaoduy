
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_button.dart';
import 'package:ramtha/helper/custom/custom_text_feild.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import '../../helper/custom/custom_drop_down.dart';
import 'create_account_controller.dart';

class CreateAccountScreen extends StatelessWidget {
  CreateAccountScreen({Key? key}) : super(key: key);
  String dropdownValue = 'Test1';

  @override
  Widget build(BuildContext context) {
    String selectedOption = "";
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        appBar: AppBar(
          title: const Text("انشاء حساب",
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: AppColors.whiteColor)),
          backgroundColor: AppColors.mainColor,
          elevation: 0,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SvgPicture.asset(
                AppImages.logo,
                height: 30,
              ),
            )
          ],
          centerTitle: true,
        ),
        body: GetBuilder<CreateAccountController>(
            init: CreateAccountController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Get.offAll(() => const MainScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [],
                          ),
                        ),
                      ],
                    ),
                    Wrap(
                      runSpacing: 20,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.userNameFromThreeSection,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  filled: true,
                                  fillColor: AppColors.editTextColor,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: SvgPicture.asset(
                                      AppImages.iconProfile,
                                      height: 2,
                                    ),
                                  ),
                                  hintText: "الأسم من ثلاث مقاطع",
                                  helperStyle: TextStyle(
                                      color: Colors.black.withOpacity(.5)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 2)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    // borderSide:
                                    //     BorderSide(color: AppColors.textColor, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء ادخال الاسم';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),
                            ),
                          ],
                        ),
                        CustomTextField<String>(
                          controller: controller.userNameFromThreeSection,
                          isRequired: true,
                          suffixIcon: "",
                          hintText: "احمد الحماد",
                          title: "اسم صاحب الرقم",
                          lightLabel: true,
                          validator: (v) {
                            if (v?.isEmpty ?? true) return 'الحقل فارخ';
                            return null;
                          },
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.userNameForRegister,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  filled: true,
                                  fillColor: AppColors.editTextColor,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: SvgPicture.asset(
                                      AppImages.iconProfile,
                                      height: 2,
                                    ),
                                  ),
                                  hintText: "الأسم المستخدم لتسجيل",
                                  helperStyle: TextStyle(
                                      color: Colors.black.withOpacity(.5)),
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 2)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                    // borderSide:
                                    //     BorderSide(color: AppColors.textColor, width: 2),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء ادخال الاسم';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.password,
                                obscureText: controller.visiblePassword,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 70,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller.onPressedVisible();
                                            },
                                            child: SvgPicture.asset(
                                              AppImages.iconUnVisible,
                                              fit: BoxFit.fitHeight,
                                              color: controller.visiblePassword
                                                  ? AppColors.blueButtonColor
                                                  : null,
                                              height: 25,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller.onPressedUnVisible();
                                            },
                                            child: SvgPicture.asset(
                                              AppImages.iconVisible,
                                              fit: BoxFit.fitHeight,
                                              color: !controller.visiblePassword
                                                  ? AppColors.blueButtonColor
                                                  : null,
                                              height: 23,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  hintText: "كلمة السر",
                                  helperStyle: TextStyle(
                                      color: Colors.black.withOpacity(.5)),
                                  filled: true,
                                  fillColor: AppColors.editTextColor,
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 2)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء ادخال الاسم';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.passwordConfirm,
                                obscureText: controller.visiblePasswordConfirm,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 10),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 70,
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller.onPressedVisible();
                                            },
                                            child: SvgPicture.asset(
                                              AppImages.iconUnVisible,
                                              fit: BoxFit.fitHeight,
                                              color: controller.visiblePassword
                                                  ? AppColors.blueButtonColor
                                                  : null,
                                              height: 25,
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              controller.onPressedUnVisible();
                                            },
                                            child: SvgPicture.asset(
                                              AppImages.iconVisible,
                                              fit: BoxFit.fitHeight,
                                              color: !controller.visiblePassword
                                                  ? AppColors.blueButtonColor
                                                  : null,
                                              height: 23,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  hintText: "تأكيد كلمة السر",
                                  helperStyle: TextStyle(
                                      color: Colors.black.withOpacity(.5)),
                                  filled: true,
                                  fillColor: AppColors.editTextColor,
                                  enabledBorder: const OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(15)),
                                      borderSide: BorderSide(
                                          color: Colors.transparent, width: 2)),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(15)),
                                  ),
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'الرجاء ادخال الاسم';
                                  }
                                  return null;
                                },
                                onSaved: (value) {},
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Text(
                                    "المحافظة",
                                    style: TextStyle(
                                        color: AppColors.whiteColor
                                            .withOpacity(.6)),
                                  )
                                ],
                              ),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          underline: const SizedBox(),
                                          value: dropdownValue,
                                          iconEnabledColor: Colors.black,
                                          dropdownColor: Colors.grey.shade200,
                                          items: <String>[
                                            'Test1',
                                            'Test2',
                                            'Test3',
                                            'Test4',
                                            'Test4',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Text(
                                    "اللواء",
                                    style: TextStyle(
                                        color: AppColors.whiteColor
                                            .withOpacity(.6)),
                                  )
                                ],
                              ),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          underline: const SizedBox(),
                                          value: dropdownValue,
                                          iconEnabledColor: Colors.black,
                                          dropdownColor: Colors.grey.shade200,
                                          items: <String>[
                                            'Test1',
                                            'Test2',
                                            'Test3',
                                            'Test4',
                                            'Test4',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                        ),
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 5),
                              child: Row(
                                children: [
                                  Text(
                                    "القضاء",
                                    style: TextStyle(
                                        color: AppColors.whiteColor
                                            .withOpacity(.6)),
                                  )
                                ],
                              ),
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          underline: const SizedBox(),
                                          value: dropdownValue,
                                          iconEnabledColor: Colors.black,
                                          dropdownColor: Colors.grey.shade200,
                                          items: <String>[
                                            'Test1',
                                            'Test2',
                                            'Test3',
                                            'Test4',
                                            'Test4',
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(
                                                value,
                                                style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
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
                        ),
                        Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            CustomButton(
                              color: AppColors.blueButtonColor,
                              title: "انشاء حساب",
                              height: 50,
                              colorTitle: AppColors.whiteColor,
                              pressed: () {
                                // Get.to(()=> CreateAccountScreen());
                              },
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ]),
                ),
              );
            }),
      ),
    );
  }
}
