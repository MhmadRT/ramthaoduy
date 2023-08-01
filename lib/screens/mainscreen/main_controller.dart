import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/helper/functiona_helper.dart';
import 'package:ramtha/helper/local_storage_helper.dart';
import 'package:ramtha/screens/homescreen/home_screen.dart';
import 'package:ramtha/screens/loginscreen/login_screen.dart';
import 'package:ramtha/screens/loginscreen/model/login_response.dart';
import 'package:ramtha/screens/mainscreen/main_repository.dart';
import 'package:ramtha/screens/searchscreen/search_sceen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uni_links/uni_links.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../helper/custom/topics_dialog.dart';
import '../../helper/notification_config.dart';
import '../deathformscreen.dart/add_death_screen.dart';
import '../homescreen/home_conrtoller.dart';
import '../homescreen/home_repository.dart';
import '../homescreen/model/get_number_readed_notification.dart';
import '../homescreen/model/get_user_info.dart';
import '../notifcation/notifcation_screen.dart';

class MainController extends GetxController {
  int currentIndex = 2;
  LoginResponseData? loginResponseData;
  bool? isLogin;
  MainRepository mainRepository = MainRepository();
  GetUserInfoResponse? userInfoResponse;
  HomeRepository repository = HomeRepository();
  GetNumberNotReaded getNumberNotReaded = GetNumberNotReaded();
  bool isLoadingUserData = true;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool isLoadingCount = false;
  bool isAppExiting = false;

  List<Widget> screens = [
    const SearchScreen(),
    const FormDeathScreen(),
    const HomeScreen(),
    const NotificationScreen()
  ];
  List<String> title = ["البحث", "اضافة وفاة", "الرئيسية", "الأشعارات"];
  Uri? _latestUri;
  bool _isAppExiting = false;
  late Timer _exitTimer;

  Future<bool> onWillPop() async {
    if (currentIndex == 2) {
      if (_isAppExiting) {
        return true;
      } else {
        _isAppExiting = true;

        _exitTimer = Timer(const Duration(seconds: 2), () {
          _isAppExiting = false;
        });
        return false;
      }
    } else {
      currentIndex = 2;
      update();
    }
    return false;
  }

  Future<String> getMobileVersion() async {
    return await PackageInfo.fromPlatform().then((PackageInfo packageInfo) {
      String appName = packageInfo.appName;
      String packageName = packageInfo.packageName;
      String version = packageInfo.version;
      String buildNumber = packageInfo.buildNumber;
      return version;
    });
  }

  Future<void> share() async {
    loading();
    var url = '';
    if (Platform.isAndroid || Platform.isIOS) {
      final appId = Platform.isAndroid ? 'com.ramtha.dead' : 'com.ramtha.dead';
      url = Platform.isAndroid
          ? "market://details?id=$appId"
          : "https://apps.apple.com/app/id$appId";
    }
    await Future.delayed(const Duration(seconds: 1));
    await FlutterShare.share(
        title: "وفيات الرمثاء",
        text: 'حمل تطبيق وفيات الرمثاء',
        linkUrl: url ?? "",
        chooserTitle: "وفيات الرمثاء");
    closeLoading();
  }

  getUserData() async {
    Map<String, dynamic> body = {};
    isLoadingUserData = true;
    update();
    userInfoResponse = await mainRepository.getUserInfo(body);
    isLoadingUserData = false;
    print(body);
    update();
  }

  getNumberNotifications() async {
    update();
    isLoadingCount = true;
    getNumberNotReaded = await repository.getNumberNotifications({});
    isLoadingCount = false;
    update();
  }

  @override
  void onInit() async {
    // TODO: implement onInit
    await getUserData();
    await getNumberNotifications();
    loginResponseData = await LocalStorageHelper.getUserData();
    isLogin = await LocalStorageHelper.isLoggedIn();
    update();
    LocalStorageHelper.getTopics().then((value) {
      if (value?.isEmpty ?? true) {
        Get.dialog(const SubscribeDialog());
      }
    });
    checkLastNotification();
    checkDeepLink();

    super.onInit();
  }

  void checkDeepLink() {
    if (!kIsWeb) {
      uriLinkStream.listen((Uri? uri) async {
        _latestUri = uri;

        final queryParams = _latestUri?.queryParametersAll.entries.toList();
        String? id;
        if (queryParams != null) {
          for (final item in queryParams) {
            if (item.key == 'id' && item.value.isNotEmpty) {
              id = item.value.first;
              break;
            }
          }
          if (id != null) {
            FunctionsHelper.goToPostByID(postID: id);
          }
        }
      }, onError: (_) {
        _latestUri = null;
      });
    }
  }

  void checkLastNotification() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? str = pref.getString(StorageKeys.lastNotification);
    pref.setString(StorageKeys.lastNotification, '');
    await pref.remove(StorageKeys.lastNotification);
    if (str != 'null' && str != '' && str != null) {
      Map<String, dynamic> someData = jsonDecode(str);
      PayloadData payloadData = PayloadData.fromJson((someData));
      print('CHECK NOTIFICATION ON BASE ${payloadData.toJson().toString()}');
      if (payloadData.postId != null) {
        FunctionsHelper.goToPostByID(postID: payloadData.postId ?? "");
      }
    }
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
