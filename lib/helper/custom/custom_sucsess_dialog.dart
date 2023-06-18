import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/helper/custom/custom_button.dart';

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({Key? key, this.massage}) : super(key: key);
  final String? massage;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white),
                  child: Column(children: [
                    SvgPicture.asset(
                      AppImages.sucsessMassege,
                      height: 80,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      massage.toString(),
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomButton(
                        color: AppColors.mainColor,
                        title: "اغلاق",
                        height: 40,
                        colorTitle: AppColors.whiteColor,
                        pressed: () {
                          Get.back();
                        })
                  ]),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
