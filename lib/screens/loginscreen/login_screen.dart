import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/screens/createaccountscreen/create_account_screen.dart';
import 'package:ramtha/screens/mainscreen/main_screen.dart';

import '../../constant/app_images.dart';
import '../../helper/custom/custom_button.dart';
import 'login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: GetBuilder<LoginController>(
            init: LoginController(),
            builder: (controller) {
              return Padding(
                padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAll(() =>   MainScreen());
                          },
                          child: Row(
                            children: [
                              const Text("تخطي",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.whiteColor)),
                              const SizedBox(
                                width: 10,
                              ),
                              SvgPicture.asset(AppImages.iconArrowLeft,
                                  height: 18),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Center(
                        child: SvgPicture.asset(
                      AppImages.logo,
                      height: Get.height / 3,
                    )),
                    Wrap(
                      runSpacing: 20,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: controller.userName,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 15, horizontal: 10),
                                  filled: true,
                                  fillColor: AppColors.editTextColor,
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.all(9.0),
                                    child: SvgPicture.asset(
                                      AppImages.iconProfile,
                                      height: 2,
                                    ),
                                  ),
                                  hintText: "أسم المستخدم او البريد الألكتروني",
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
                                      vertical: 15, horizontal: 10),
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
                              child: GestureDetector(
                                onTap: () {
                                  controller.isRememberMe =
                                      !controller.isRememberMe;
                                  controller.update();
                                },
                                child: Row(
                                  children: [
                                    AnimatedSwitcher(
                                      duration: const Duration(milliseconds: 300),
                                      child: controller.isRememberMe
                                          ? const Icon(Icons.check_box_outlined,
                                              color: AppColors.whiteColor)
                                          : const Icon(
                                              Icons
                                                  .check_box_outline_blank_outlined,
                                              color: AppColors.whiteColor),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    const Text(
                                      "تذكرني",
                                      style: TextStyle(
                                        color: AppColors.whiteColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const Text(
                              "نسيت كلمة السر ؟",
                              style: TextStyle(
                                color: AppColors.whiteColor,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        CustomButton(
                          color: AppColors.defaultButtonColor,
                          title: "دخول",
                          height: 50,
                          colorTitle: AppColors.whiteColor,
                          pressed: () {
                            controller.login();
                          },
                        ),
                        CustomButton(
                          color: AppColors.blueButtonColor,
                          title: "انشاء حساب",
                          height: 50,
                          colorTitle: AppColors.whiteColor,
                          pressed: () {
                            Get.to(()=> CreateAccountScreen());
                          },
                        ),
                        Column(
                          children: [
                            const Center(
                              child: Text(
                                "اذا كان لديك اي استفسار لا تترد في التواصل معنا",
                                style: TextStyle(
                                  color: AppColors.whiteColor,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Center(
                                child: Text(
                                  " التواصل معنا",
                                  style: TextStyle(
                                    color: AppColors.blueButtonColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ),
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
