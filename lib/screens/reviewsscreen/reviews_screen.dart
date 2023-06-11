import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';

import '../../helper/custom/custom_button.dart';
import '../../helper/custom/custom_card_info.dart';
import '../../helper/custom/custom_review_card.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
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
                              "منشورات تحتاج موافقة",
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
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      children: [
                        CustomReviewCard(
                          age: "50 سنة",
                          date: "2022.08.22",
                          image:
                              "https://www.sayidaty.net/sites/default/files/styles/900_scale/public/2019/12/03/6145006-1029464460.jpg",
                          name: "احمد مرتضى ابو حمادة",
                          period: "منذ 5 ساعات",
                          town: "الرمثا",
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 10,
            right: 0,
            left: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                    color: AppColors.red,
                    title: " رفض الكل",
                    colorTitle: AppColors.whiteColor,
                    height: 30,
                    pressed: () {},
                    width: Get.width / 2.3),
                const SizedBox(
                  width: 10,
                ),
                CustomButton(
                    color: AppColors.mainColor,
                    title: " قبول الكل",
                    colorTitle: AppColors.whiteColor,
                    height: 30,
                    pressed: () {},
                    width: Get.width / 2.3),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
