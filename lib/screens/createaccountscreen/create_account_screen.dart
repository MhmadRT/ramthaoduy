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
                        title: "الأسم من اربع مقاطع",
                        hintText: 'محمد احمد علي رمضان',
                        lightLabel: true,
                        validator: (v) {
                          if (v?.isEmpty ?? true) return 'الحقل فارغ';
                          if (!controller.hasThreeSpaces(v ?? "")) {
                            return "الرجاء ادخال الأسم من اربع مقاطع";
                          }
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
                        title: "الأسم المستخدم للتسجيل",
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          // Deny whitespace characters
                        ],
                        hintText: 'user123',
                        lightLabel: true,
                        validator: (v) {
                          if (v?.isEmpty ?? true) return 'الحقل فارغ';
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField<String>(
                        maxLength: 10,
                        controller: controller.idNumber,
                        inputType: TextInputType.number,
                        isRequired: true,
                        suffixSvgIconName: '',
                        title: "الرقم الوطني",
                        inputFormatters: [
                          FilteringTextInputFormatter.deny(RegExp(r"\s")),
                          // Deny whitespace characters
                        ],
                        hintText: '',
                        lightLabel: true,
                        validator: (v) {
                          if (v?.isEmpty ?? true) return 'الحقل فارغ';
                          if ((v?.length ?? 0) < 10) {
                            return 'يجب ان يكون الرقم الوطني مكون من 10 ارقام';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _buildSelectSex(controller),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField<String>(
                        controller: controller.email,
                        isRequired: true,
                        suffixSvgIconName: '',
                        title: "البريد الاكتروني",
                        hintText: 'example@gmail.com',
                        lightLabel: true,
                        validator: (v) {
                          if (v?.isEmpty ?? true) return 'الحقل فارغ';
                          if (!GetUtils.isEmail(v ?? '')) {
                            return 'البريد الاكتروني غير صحيح';
                          }
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
                        isSecure: controller.visiblePassword,
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
                          if (v?.isEmpty ?? true) return 'الحقل فارغ';
                          if ((v?.length ?? 0) < 6) {
                            return 'يجب ان تتكون كلمة المرور من 6 مقاطع او اكثر';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomTextField<String>(
                        controller: controller.passwordConfirm,
                        isRequired: true,
                        isSecure: controller.visiblePasswordConfirm,
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
                          if (v?.isEmpty ?? true) return 'الحقل فارغ';
                          if ((v?.length ?? 0) < 6) {
                            return 'يجب ان تتكون كلمة المرور من 6 مقاطع او اكثر';
                          }
                          if (v != controller.password.text) {
                            return 'كلمة السر غير مطابقه';
                          }
                          return null;
                        },
                      ),

                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // CustomDropdown(
                      //     listItems: controller.cities.cities ?? [],
                      //     selectedItem: controller.selectedCity,
                      //     lightLabel: true,
                      //     isRequired: true,
                      //     label: 'المحافظة',
                      //     onSelected: (v) {
                      //       controller.selectedCity = v;
                      //       controller.update();
                      //       controller.getBrigades();
                      //     }),
                      // const SizedBox(
                      //   height: 10,
                      // ),
                      // CustomDropdown(
                      //     lightLabel: true,
                      //     isRequired: true,
                      //     label: 'الواء',
                      //     listItems: controller.brigades.brigades ?? [],
                      //     selectedItem: controller.selectedBrigade,
                      //     onSelected: (v) {
                      //       controller.selectedBrigade = v;
                      //       controller.update();
                      //       controller.getDistrict();
                      //     }),
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
                        color: AppColors.yellow,
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
                      const SizedBox(
                        height: 50,
                      ),
                    ]),
                  ),
                ),
              );
            }),
      ),
    );
  }

  _buildSelectSex(CreateAccountController controller) {
    return Column(
      children: [
        const Row(
          children: [
            Text("الجنس",
                style: TextStyle(
                    fontSize: 15,
                    color: AppColors.whiteColor,
                    fontWeight: FontWeight.w500)),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: () {
                controller.selectSexIndex = 1;
                print(controller.selectSexIndex);
                controller.update();
              },
              child: Container(
                width: Get.width / 2.6,
                height: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: controller.selectSexIndex == 1
                        ? AppColors.yellow
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
                        ? AppColors.yellow
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
