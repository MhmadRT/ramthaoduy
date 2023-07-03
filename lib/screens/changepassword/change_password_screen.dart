import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/changepassword/change_password_controller.dart';

import '../../constant/app_colors.dart';
import '../../helper/custom/custom_button.dart';
import '../../helper/custom/custom_text_feild.dart';

class ChangePasswordScreen extends StatelessWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 80,
            decoration: const BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15))),
            child: Column(
              children: [
                const SizedBox(
                  height: 45,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back_ios,
                            color: AppColors.whiteColor, size: 15),
                      ),
                      Container(
                        alignment: Alignment.center,
                        child: const Text(
                          "تغير كلمة المرور",
                          style: TextStyle(
                              color: AppColors.whiteColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<ChangePasswordController>(
                init: ChangePasswordController(),
                builder: (controller) {
                  return SingleChildScrollView(
                      padding: const EdgeInsets.all(20),
                      child: Form(
                        key: controller.formKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField<String>(
                              controller: controller.oldPassword,
                              isRequired: true,
                              isSecure: !controller.oldVisiblePassword,
                              suffixSvgIconName: '',
                              title: "كلمة السر القديمه",
                              suffixIcon: InkWell(
                                onTap: () {
                                  controller.oldVisiblePassword =
                                      !controller.oldVisiblePassword;
                                  controller.update();
                                },
                                child: Icon(
                                  controller.oldVisiblePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: controller.oldVisiblePassword
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
                            const SizedBox(
                              height: 10,
                            ),
                            CustomTextField<String>(
                              controller: controller.newPassword,
                              isRequired: true,
                              suffixSvgIconName: '',
                              isSecure: !controller.visiblePassword,
                              title: "كلمة السر الجديده",
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
                              controller: controller.confirmPassword,
                              isRequired: true,
                              isSecure: !controller.visiblePasswordConfirm,
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
                              title: "تأكيد كلمة السر الجديده",
                              validator: (v) {
                                if (v?.isEmpty ?? true) return 'الحقل فارخ';
                                if ((v?.length ?? 0) < 6) {
                                  return 'يجب ان تتكون كلمة المرور من 6 مقاطع او اكثر';
                                }
                                if (v != controller.newPassword.text) {
                                  return 'كلمة السر غير مطابقه';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomButton(
                              color: AppColors.defaultButtonColor,
                              title: "دخول",
                              height: 50,
                              colorTitle: AppColors.whiteColor,
                              pressed: () {
                                controller.changePassword();
                              },
                            ),
                          ],
                        ),
                      ));
                }),
          )
        ],
      ),
    );
  }
}
