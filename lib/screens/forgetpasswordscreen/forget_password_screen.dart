import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import '../../helper/custom/custom_button.dart';
import 'forget_password_controller.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.mainColor,
        body: GetBuilder<ForgetPasswordController>(
            init: ForgetPasswordController(),
            builder: (controller) {
              return SingleChildScrollView(
                child: Column(
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
                                      color: AppColors.whiteColor, size: 20),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "تسجيل الدخول",
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
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 20, right: 20),
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(children: [
                          Center(
                              child: SvgPicture.asset(
                                AppImages.logo,
                                height: Get.height / 3.5,
                              )),
                          const Row(
                            children: [

                              Expanded(
                                  child: Text(
                                "تم نسيان كلمة المرور؟",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.whiteColor,fontSize: 16),
                              )),
                            ],
                          ),
                          const Row(
                            children: [
                              Expanded(
                                child: Text(
                                    "يرجى إدخال عنوان البريد الإلكتروني المرتبط بحسابك. سنرسل إليك رابطًا لإعادة تعيين كلمة المرور.",
                                    textAlign: TextAlign.center, style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.whiteColor),),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: controller.emailController,
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                    filled: true,
                                    fillColor: AppColors.editTextColor,
                                    suffixIcon: const Padding(
                                        padding: EdgeInsets.all(9.0),
                                        child: Icon(Icons.email_outlined)),
                                    hintText: "البريد الألكتروني",
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
                          const SizedBox(
                            height: 50,
                          ),
                          CustomButton(
                            color: AppColors.defaultButtonColor,
                            title: "ارسال",
                            height: 50,
                            colorTitle: AppColors.whiteColor,
                            pressed: () {
                              controller.validate();
                            },
                          ),
                          const Visibility(
                            visible: false,
                            child: Text(
                                "سيتم إرسال رابط إعادة تعيين كلمة المرور إلى عنوان بريدك الإلكتروني المسجل. يُرجى التحقق من صندوق البريد الوارد أو الرسائل غير المرغوب فيها."),
                          ),
                        ]),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}
