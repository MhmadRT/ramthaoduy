import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';

class CustomSnackBar extends StatelessWidget {
  final String message;
  final Color backgroundColor;
  final Duration duration;

  CustomSnackBar({
    required this.message,
    required this.backgroundColor,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return GetSnackBar(
      messageText: Text(
        message,
        style: const TextStyle(color: AppColors.blueButtonColor),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
    );
  }

  static void showCustomSnackBar({
    required String message,
    required Color backgroundColor,
    required Duration duration,
  }) {
    Get.rawSnackbar(
      borderRadius: 25,
      icon: InkWell(
          onTap: () {
            Get.back();
          },
          child: const Icon(Icons.close,color: Colors.redAccent,)),
      padding: const EdgeInsets.all(30),
      snackStyle: SnackStyle.FLOATING,
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: backgroundColor,
      duration: duration,
    );
  }
}
