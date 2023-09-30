import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ramtha/screens/subcategory/sub_category_repo.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helper/custom/custom_drop_down.dart';
import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/custom_toast_massage.dart';
import '../category/category_controller.dart';
import '../createaccountscreen/models/brigades.dart';
import '../createaccountscreen/models/cities.dart';
import '../createaccountscreen/models/degree_of_kinship_model.dart';
import '../createaccountscreen/models/districts.dart';
import 'model/sub_category_model.dart';

class SubCategoryController extends GetxController {
  SubCategoryRepository subCategoryRepository = SubCategoryRepository();
  Districts districts = Districts(districts: []);
  Item selectedDistrict = Item(name: 'الكل');
  GetServiceClassificationModelResponse getResponse =
      GetServiceClassificationModelResponse(
          data: Data(serviceClassification: []));
  int? idSelectedFromSub;

  bool isLoading = false;

  @override
  void onInit() async {
    // TODO: implement onInit
    await Future.delayed(Duration.zero).then((value) => getDistrict());

    super.onInit();
  }

  serviceClassification() async {
    isLoading = true;

    Map<String, dynamic> body = {
      "sub_service_id": Get.find<CategoryController>().idCategory,
      "district_id": selectedDistrict.id,
    };

    update();
    await subCategoryRepository
        .getServiceClassification(body)
        .then((value) async {
      isLoading = false;
      update();
      if (value.status == '1') {
        getResponse = value;
      } else {
        CustomSnackBar.showCustomSnackBar(
          message: value.message,
        );
      }
    });
    update();
  }

  whenClickPhoneNumber({ index}) async {
    loading();
    Map<String, dynamic> body = {
      "id": getResponse.data?.serviceClassification?[index].id.toString(),
    };
    await subCategoryRepository.clickAction(body).then((value) => () {
          Get.back();


        });
    update();
  }

  void launchPhoneDialer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';

    await launchUrl(Uri.parse(url));
    Get.back();
  }

  getDistrict() async {
    isLoading = true;
    update();
    // loading();
    districts = await subCategoryRepository.getDistricts(brigadeId: "1");
    districts.districts?.insert(0, Item(id: "-1", name: "الكل"));
    selectedDistrict = districts.districts![0];
    await serviceClassification();
    update();
    // closeLoading();
  }
}
