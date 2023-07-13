import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/screens/about_screen/about_screen.dart';

class NotificationCardWidget extends StatelessWidget {
  const NotificationCardWidget(
      {Key? key, this.title, this.date, this.subtitle, this.id})
      : super(key: key);
  final String? title;
  final String? subtitle;
  final String? date;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (id == 1) {
          Get.to(const AboutScreen());
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppColors.cardColor),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.mainColor.withOpacity(.8),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: SvgPicture.asset(AppImages.notificationDownIcon,
                        color: AppColors.whiteColor, height: 20),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              title ?? "العنوان الرئيسي",
                              style: const TextStyle(
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                          ),
                          Text(
                            date ?? "2022/03/5",
                            style: TextStyle(
                                color: Colors.grey.shade500, fontSize: 12),
                          ),
                        ],
                      ),
                      Text(
                        subtitle ?? "العنوان الفرعي",
                        style: const TextStyle(
                            color: AppColors.mainColor,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
