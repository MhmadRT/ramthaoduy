import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/screens/splashscreen/splash_controller.dart';
import 'package:ramtha/screens/splashscreen/widget/animations.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mainColor,
      body: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (controller) {
            return ChangeImageWidget();
          }),
    );
  }
}
