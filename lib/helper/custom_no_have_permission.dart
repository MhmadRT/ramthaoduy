import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/loginscreen/login_screen.dart';

import '../constant/app_colors.dart';

class DialogPermission extends StatelessWidget {
  const DialogPermission({super.key,  this.massageOperation});

  final String? massageOperation;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Dialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Column(children: [
                  const Row(
                      children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      " يرجى تسجيل الدخول لاتمام العملية",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text("اغلاق",
                              style: TextStyle(color: AppColors.whiteColor)),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => const LoginScreen());
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text("دخول",
                              style: TextStyle(color: AppColors.whiteColor)),
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
        ),
      ],
    );
  }
}
