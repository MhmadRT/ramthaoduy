import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/helper/local_storage_helper.dart';
import 'package:ramtha/network/api_response_model.dart';
import 'package:ramtha/screens/homescreen/home_screen.dart';
import 'package:ramtha/screens/loginscreen/login_screen.dart';
import 'package:ramtha/screens/mainscreen/main_repository.dart';
import 'package:ramtha/screens/searchscreen/search_sceen.dart';

import '../deathformscreen.dart/add_death_screen.dart';
import '../deathformscreen.dart/death_controller.dart';

class MainController extends GetxController {
  int currentIndex = 2;
  MainRepository mainRepository = MainRepository();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<Widget> screens = [
    const SearchScreen(),
    const FormDeathScreen(),
    const HomeScreen(),
    Container(
      height: 100,
      width: Get.width,
      color: Colors.yellow,
    ),
  ];
  List<String> title = ["البحث", "اضافة وفاة", "الرئيسية", "الأشعارات"];

  makeLogOut() async {
    loading();
    await mainRepository.makeLogOutAPI({});
    await LocalStorageHelper.clearCredentials();
    closeLoading();
    Get.offAll(const LoginScreen());
  }
}
