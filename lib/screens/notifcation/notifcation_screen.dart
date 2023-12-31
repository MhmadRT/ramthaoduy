import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/helper/custom/no_data_widget.dart';
import 'package:ramtha/screens/homescreen/home_conrtoller.dart';

import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import 'notifcation_controller.dart';
import 'widget/notifcation_card_widget.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<NotificationController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.isLoading
                  ? (controller.getNotificationsResponse.data?.length ?? 0) + 1
                  : controller.getNotificationsResponse.data?.length,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                if (controller.isLoading &&
                    index == controller.getNotificationsResponse.data?.length) {
                  return loadingNotification();
                }
                return NotificationCardWidget(
                  title:
                      controller.getNotificationsResponse.data?[index].title ??
                          "",
                  date: controller
                          .getNotificationsResponse.data?[index].createdAt ??
                      "",
                  subtitle:
                      controller.getNotificationsResponse.data?[index].body ??
                          "",
                  id: controller.getNotificationsResponse.data?[index].id ?? 0,
                );
              }),
          Visibility(
            visible:
                (controller.getNotificationsResponse.data?.isEmpty ?? false) &&
                    controller.isLoading == false,
            child: const Center(
                child: NoDataWidget(
              title: "لا يوجد اشعارات",
            )),
          )
        ],
      );
    });
  }

  loadingNotification() {
    return ListView.builder(
        itemCount: 5,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: AppColors.cardColor),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.mainColor.withOpacity(.8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: SvgPicture.asset(AppImages.notificationDownIcon,
                            color: AppColors.whiteColor, height: 20),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomLoading(
                                  height: 10,
                                  radius: 5,
                                  width: 100,
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              CustomLoading(height: 5, radius: 5, width: 80),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          CustomLoading(height: 10, radius: 5, width: 100),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
