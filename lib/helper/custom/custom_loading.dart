import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';

import '../../constant/app_images.dart';

class CustomLoading extends StatelessWidget {
  const CustomLoading(
      {Key? key,
      this.width = 10,
      this.height = 10,
      this.radius = 15,
      this.color})
      : super(key: key);
  final double? width;
  final double? height;
  final double? radius;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius!),
      child: Image.asset(
        color: color,
        AppImages.loading,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}

loading() {
  Get.closeCurrentSnackbar();
  Get.closeAllSnackbars();
  Get.dialog(
      WillPopScope(
        onWillPop: () {
          return Future.value(false);
        },
        child: Column(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Card(
              child: Container(
                width: 100,
                decoration: BoxDecoration(color: AppColors.whiteColor,borderRadius: BorderRadius.circular(5)),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Dialog(
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.transparent,
                    insetAnimationDuration: Duration.zero,
                    elevation: 0,
                    child: Center(
                      child: CupertinoActivityIndicator(color: AppColors.mainColor,radius: 20),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      barrierColor: Colors.white24,
      barrierDismissible: false);
}

closeLoading() {
  Get.back();
}
