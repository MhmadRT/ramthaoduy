import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_button.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import 'contact_us_controller.dart';

class ContactUsScreen extends StatelessWidget {
  const ContactUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ContactUsController>(
        init: ContactUsController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.mainColor,
            body: Column(children: [
              Container(
                height: 85,
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
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(Icons.arrow_back_ios,
                                  color: AppColors.whiteColor, size: 15),
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "دعم العملاء",
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
                padding: EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Center(
                        child: SvgPicture.asset(
                      AppImages.logo,
                      height: Get.height / 5,
                    )),
                    const SizedBox(
                      height: 20,
                    ),
                    const Row(
                      children: [
                        Expanded(
                            child: Text(
                          "هل لديك اي استفسار",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                              fontSize: 18),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Row(
                      children: [
                        Expanded(
                            child: Text(
                          "يرجى اخبارنا باستفساراتك, وسيقوم فريق الدعم الفني لدينا بالرد عليك",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.whiteColor,
                              fontSize: 18),
                        ))
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Wrap(
                      runSpacing: 10,
                      children: [
                        CustomButton(
                          color: AppColors.green,
                          title: "تواصل معنا whats App",
                          pressed: () {
                            controller.launchWhatsApp();
                          },
                          height: 40,
                          colorTitle: AppColors.whiteColor,
                          fontSize: 17,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          color: AppColors.whiteColor,
                          title: "تواصل معنا عبر Email",
                          pressed: () {
                            controller.openEmail(
                                body: "",
                                recipients: "oduy.smara@gmail.com",
                                subject: "");
                          },
                          height: 40,
                          colorTitle: AppColors.red,
                          fontSize: 17,
                          borderRadius: 10,
                        ),
                        CustomButton(
                          color: AppColors.blueButtonColor,
                          title: "تواصل معنا عبر رقم الهاتف",
                          pressed: () {
                            controller.launchPhoneDialer("0780696336");
                          },
                          height: 40,
                          colorTitle: AppColors.whiteColor,
                          fontSize: 17,
                          borderRadius: 10,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ]),
          );
        });
  }
}
