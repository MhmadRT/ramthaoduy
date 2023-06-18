import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/ratescreen/rate_controller.dart';

import '../../constant/app_colors.dart';
import '../../helper/custom/custom_button.dart';
import '../../helper/custom/custom_text_feild.dart';

class RateScreen extends StatelessWidget {
  const RateScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RateController>(
        init: RateController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Scaffold(
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
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
                                      "تقييم التطبيق",
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
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                CustomTextField(
                                  controller: controller.rateController,
                                  isRequired: false,
                                  suffixSvgIconName: "",
                                  maxLines: 5,
                                  hintText: "اضف ملاحظات",
                                  title: "",
                                  showTitle: false,
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                RatingBar.builder(
                                  initialRating: 0.0,
                                  minRating: 0,
                                  direction: Axis.horizontal,
                                  allowHalfRating: true,
                                  itemCount: 5,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 4.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: AppColors.mainColor,
                                  ),
                                  onRatingUpdate: (rating) {
                                    controller.rateValue = rating;
                                    controller.update();
                                    print(rating);
                                  },
                                ),
                                const SizedBox(
                                  height: 100,
                                ),
                                CustomButton(
                                    color: AppColors.mainColor,
                                    title: "ارسال التقييم",
                                    colorTitle: AppColors.whiteColor,
                                    height: 30,
                                    pressed: () {
                                      controller.rate();
                                    },
                                    width: Get.width),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
