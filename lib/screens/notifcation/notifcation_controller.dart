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
  bool? isLoading = false;
  GetNumberNotReaded getNumberNotReaded = GetNumberNotReaded();
  HomeRepository homeRepository = HomeRepository();

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
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
    isLoading = true;
    update();
    await notificationsRepository.getNotifications({}).then((value) async {
      isLoading = false;
      if (value.status == '1') {
        getNotificationsResponse = value;
      } else {
        CustomSnackBar.showCustomSnackBar(
          message: value.message,
        );
      }
    });
    update();
  }
}
