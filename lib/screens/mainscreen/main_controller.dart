import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/helper/local_storage_helper.dart';
import 'package:ramtha/screens/homescreen/home_screen.dart';
import 'package:ramtha/screens/loginscreen/login_screen.dart';
import 'package:ramtha/screens/loginscreen/model/login_response.dart';
import 'package:ramtha/screens/mainscreen/main_repository.dart';
import 'package:ramtha/screens/searchscreen/search_sceen.dart';
import '../deathformscreen.dart/add_death_screen.dart';

class MainController extends GetxController {
  int currentIndex = 2;
  LoginResponseData? loginResponseData;
  bool ?isLogin;
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

  Future<String> getMobileVersion() async {
    return await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      return version;
    });
  }

  Future<void> share(String? url) async {
    await FlutterShare.share(
        title: 'Example share',
        text: 'Example share text',
        linkUrl: '$url',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    loginResponseData = await LocalStorageHelper.getUserData();
    isLogin=await LocalStorageHelper.isLoggedIn();
    update();
    super.onInit();
  }
}

makeLogOut() async {
  MainRepository mainRepository = MainRepository();
  loading();
  await mainRepository.makeLogOutAPI({});
  await LocalStorageHelper.clearCredentials();
  closeLoading();
  Get.offAll(const LoginScreen());
}
