import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/ratescreen/rate_reository.dart';

import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/custom_sucsess_dialog.dart';
import '../../helper/custom/custom_toast_massage.dart';

class RateController extends GetxController {
  TextEditingController rateController = TextEditingController();
  RateRepository repository = RateRepository();

  double? rateValue;

  rate() async {
    if (rateValue != 0.0 && rateController.text.isNotEmpty) {
      loading();
      Map<String, dynamic> body = {
        "content": rateController.text,
        "rate": rateValue.toString(),
      };

      await repository.rate(body).then((value) async {
        closeLoading();
        if (value.status == '1') {
          Get.dialog(SuccessDialog(
            massage: " تمت العملية ${value.message}"

          ));

        } else {
          CustomSnackBar.showCustomSnackBar(
            duration: const Duration(seconds: 1),
            message: value.message,
          );
        }
      });
    }else{
      CustomSnackBar.showCustomSnackBar(
        duration: const Duration(seconds: 1),
        message:"الرجاء تعبئة الحقول"
      );

    }
  }
}
