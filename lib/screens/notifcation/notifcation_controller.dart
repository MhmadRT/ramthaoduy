import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helper/custom/custom_toast_massage.dart';
import '../homescreen/home_repository.dart';
import '../homescreen/model/get_number_readed_notification.dart';
import 'model/get_notifcations_response.dart';
import 'notifcation_provider.dart';

class NotificationController extends GetxController {
  NotificationsRepository notificationsRepository = NotificationsRepository();
  GetNotificationsResponse getNotificationsResponse =
      GetNotificationsResponse(data: []);
  bool isLoading = false;
  GetNumberNotReaded getNumberNotReaded = GetNumberNotReaded();
  HomeRepository homeRepository = HomeRepository();
  int pageNumber = 1;
  int countPerPage = 10;
  bool isMoreLoad = false;
  late ScrollController scrollController;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    scrollController = ScrollController()..addListener(_scrollListener);
    await getNotification();
    await readNotification();
  }

  @override
  void dispose() {
    //...

    super.dispose();
    getNumberNotifications();
    //...
  }

  getNumberNotifications() async {
    update();
    getNumberNotReaded = await homeRepository.getNumberNotifications({});
    update();
  }

  readNotification() async {
    await notificationsRepository.readNotification({}).then((value) async {});
    update();
  }

  getNotification() async {
    Map<String, dynamic> body = {"page": pageNumber.toString()};
    isLoading = true;
    update();

    await notificationsRepository.getNotifications(body).then((value) async {
      isMoreLoad = value.data?.length== 10;
      pageNumber++;

      isLoading = false;
      if (value.status == '1') {
        getNotificationsResponse.data?.addAll(value.data??[]);
      } else {
        CustomSnackBar.showCustomSnackBar(
          message: value.message,
        );
      }
    });
    update();
  }

  void _scrollListener()async {
    print('MRT${((scrollController.position.extentAfter) < 250 && isMoreLoad) } $isMoreLoad');
    if ((scrollController.position.extentAfter) < 250 && isMoreLoad) {
      print('true');
      isMoreLoad = false;
    await  getNotification();
    }
  }
}
