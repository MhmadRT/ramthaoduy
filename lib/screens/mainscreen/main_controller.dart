import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/homescreen/home_screen.dart';
import 'package:ramtha/screens/searchscreen/search_sceen.dart';

import '../deathformscreen.dart/add_death_screen.dart';
import '../deathformscreen.dart/death_controller.dart';

class MainController extends GetxController {
  int currentIndex = 2;
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
}
