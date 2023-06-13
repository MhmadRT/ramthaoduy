import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
                  child: Form(
                    key: controller.formKey,
                    child: Column(children: [
                      CustomTextField<String>(
                        controller: controller.userNameFromThreeSection,
                        isRequired: true,
                        suffixSvgIconName: '',
                        title: "الأسم من ثلاث مقاطع",
                        hintText: 'محمد احمد علي',
                        lightLabel: true,
                        validator: (v) {
                          if (v?.isEmpty ?? true) return 'الحقل فارخ';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField<String>(
                        controller: controller.userNameForRegister,
                        isRequired: true,
                        suffixSvgIconName: '',
                        title: "الأسم المستخدم لتسجيل",
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          // Deny whitespace characters
                        ],
                        hintText: 'user123',
                        lightLabel: true,
                        validator: (v) {
                          if (v?.isEmpty ?? true) return 'الحقل فارخ';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField<String>(
                        controller: controller.password,
                        isRequired: true,
                        suffixSvgIconName: '',
                        title: "كلمة السر",
                        lightLabel: true,
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.visiblePassword =
                                !controller.visiblePassword;
                            controller.update();
                          },
                          child: Icon(
                            controller.visiblePassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: controller.visiblePassword
                                ? AppColors.yellow
                                : AppColors.defaultButtonColor,
                          ),
                        ),
                        validator: (v) {
                          if (v?.isEmpty ?? true) return 'الحقل فارخ';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField<String>(
                        controller: controller.passwordConfirm,
                        isRequired: true,
                        suffixIcon: InkWell(
                          onTap: () {
                            controller.visiblePasswordConfirm =
                                !controller.visiblePasswordConfirm;
                            controller.update();
                          },
                          child: Icon(
                            controller.visiblePasswordConfirm
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: controller.visiblePasswordConfirm
                                ? AppColors.yellow
                                : AppColors.defaultButtonColor,
                          ),
                        ),
                        title: "تأكيد كلمة السر",
                        lightLabel: true,
                        validator: (v) {
                          if (v?.isEmpty ?? true) return 'الحقل فارخ';
                          if (v != controller.password.text) {
                            return 'كلمة السر غير مطابقه';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomDropdown(
                          listItems: controller.cities.cities ?? [],
                          selectedItem: controller.selectedCity,
                          lightLabel: true,
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
                          lightLabel: true,
                          isRequired: true,
                          label: 'الواء',
                          listItems: controller.brigades.brigades ?? [],
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
                          lightLabel: true,
                          isRequired: true,
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
                      CustomButton(
                        color: AppColors.blueButtonColor,
                        title: "انشاء حساب",
                        height: 50,
                        colorTitle: AppColors.whiteColor,
                        pressed: () {
                          if (controller.formKey.currentState?.validate() ??
                              false) {
                            controller.makeRegister();
                          }
                        },
                      ),
                    ]),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
