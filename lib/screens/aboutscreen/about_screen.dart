import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constant/app_colors.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                        "عن التطبيق",
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
              const Row(
                children: [
                  Expanded(
                      child: Text(
                          "تطبيق وفيات الاردن يمكنكم من متابعة الوفيات يوميا في دولة الاردن  توجه الى عناوين العزاء مباشرة من خلال التطبيق  مميزات البرنامج:"))
                ],
              ),
              const Row(
                children: [
                  Expanded(
                      child: Text(
                          "– التواصل مع هواتف العزاء مباشرة من خلال ارسال رسائل نصية أو اتصال هاتفي"))
                ],
              ),
              const Row(
                children: [
                  Expanded(
                      child: Text(
                          "– التوجه الى عناوين العزاء باستخدام نظام الملاحة و خرائط قوقل Google Maps"))
                ],
              ),
              const Row(
                children: [
                  Expanded(
                      child: Text(
                          "– مشاركة بيانات العزاء على شبكات التواصل (الواتس آب، تويتر، انستقرام … الخ)"))
                ],
              ),
              Row(
                children: [
                  Expanded(
                      child: InkWell(
                    child: Row(
                      children: [
                        const Text("للتحميل عبر الرابط التالي :"),
                        InkWell(
                          child: const Text("www.google.com",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  color: Colors.blue)),
                          onTap: () async {
                            await launchUrl(Uri.parse("www.google.com"));
                          },
                        ),
                      ],
                    ),
                  ))
                ],
              ),
              const Row(
                children: [
                  Expanded(
                      child: Text(
                          "تطبيق وفيات الرمثا يمكنكم من متابعة الوفيات يوميا في لؤاء الرمثا من خلال  التوجه الى عناوين العزاء مباشرة من خلال التطبيق ، وايضا معرفة وفيات اليوم في الاردن ايضا"))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
