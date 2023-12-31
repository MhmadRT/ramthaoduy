import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:ramtha/helper/local_storage_helper.dart';
import 'package:ramtha/screens/splashscreen/splash_screen.dart';

import 'constant/app_colors.dart';
import 'helper/notification_config.dart';
import 'network/base_api.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('BACK GROUND MESSAGING HANDLER');
  showFlutterNotification(message);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await setupFlutterNotifications();
  await initialFireBaseMessages();
  await LocalStorageHelper.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      // DeviceOrientation.landscapeRight,
    ]);
    return GetMaterialApp(
        navigatorKey: BaseAPI.alice.getNavigatorKey(),
        debugShowCheckedModeBanner: false,
        locale: const Locale("ar"),
        fallbackLocale: const Locale('ar'),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
        theme: ThemeData(
            scaffoldBackgroundColor: AppColors.whiteColor,
            fontFamily: 'Tajawal'),
        supportedLocales: const [Locale('ar'), Locale('en')],
        home: const SplashScreen());
  }
}
