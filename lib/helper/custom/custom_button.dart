import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';

class CustomButton extends StatelessWidget {
  final Color color;
  final Color? colorTitle;
  final String title;
  final VoidCallback pressed;
  final int? fontSize;
  double? width = Get.width;
  double? height = 70;
  final double? borderRadius;

  CustomButton({
    required this.color,
    required this.title,
    required this.pressed,
    this.borderRadius = 10,
    this.colorTitle,
    this.fontSize,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.zero,
      onPressed: pressed,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 10),
          color: color,
        ),
        child: Center(
            child: Text(title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: colorTitle,
                ))),
      ),
    );
  }
}
