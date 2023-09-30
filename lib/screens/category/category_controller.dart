import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/searchscreen/search_repository.dart';

import '../../constant/app_images.dart';
import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/custom_toast_massage.dart';
import '../homescreen/model/posts_request.dart';
import '../homescreen/model/posts_response.dart';
import 'category_reository.dart';
import 'model/category_response_model.dart';

class CategoryController extends GetxController {
  CategoryRepository categoryRepository = CategoryRepository();
  CategoryResponseModel getMainCategory =
      CategoryResponseModel(data: Data(category: []));
  bool isLoading = false;
  int? idCategory ;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await getMainCategories();
  }

  getMainCategories() async {
    Map<String, dynamic> body = {};
    isLoading = true;
    Future.delayed(Duration.zero).then((value) => loading());
    update();
    await categoryRepository.getMainCategory(body).then((value) async {
      Get.back();
      isLoading = false;
      if (value.status == '1') {
        getMainCategory = value;
      } else {
        CustomSnackBar.showCustomSnackBar(
          message: value.message,
        );
      }
    });
    update();
  }
}
