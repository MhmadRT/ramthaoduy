import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/screens/ratescreen/rate_screen.dart';
import 'package:ramtha/screens/reviewsscreen/reviews_screen.dart';

import '../../constant/app_images.dart';
import 'main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          key: scaffoldKey,
          drawer: Drawer(
              width: Get.width / 1.3,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Row(
                          children: [
                            CircleAvatar(
                              maxRadius: 35,
                              backgroundImage: NetworkImage(
                                  'https://www.sayidaty.net/sites/default/files/styles/900_scale/public/2019/12/03/6145006-1029464460.jpg'),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("احمد محمد احمد",
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.w600)),
                                Text("الرمثا",
                                    style: TextStyle(
                                        color: AppColors.mainColor,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            SvgPicture.asset(
                              AppImages.editIcon,
                              height: 20,
                            ),
                            Text("تعديل",
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(.5),
                                    fontWeight: FontWeight.normal)),
                          ],
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const ReviewsScreen());
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(AppImages.shareMenuIcon, height: 20),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("منشورات تحتاج موافقة",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppImages.shareMenuIcon, height: 20),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("مشاركة التطبيق",
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppImages.aboutMenuIcon, height: 20),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text("عن التطبيق",
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.mainColor,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () {
                        Get.to(() => const RateScreen());
                      },
                      child: Row(
                        children: [
                          SvgPicture.asset(AppImages.starMenuIcon, height: 20),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text("تقييم التطبيق",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: AppColors.mainColor,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    GetBuilder<MainController>(builder: (con) {
                      return InkWell(
                        onTap: () {
                          con.makeLogOut();
                        },
                        child: Row(
                          children: [
                            SvgPicture.asset(AppImages.loginMenuIcon,
                                height: 20),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text("تسجيل خروج",
                                style: TextStyle(
                                    fontSize: 15,
                                    color: Colors.red,
                                    fontWeight: FontWeight.w600)),
                          ],
                        ),
                      );
                    }),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              )),
          resizeToAvoidBottomInset: false,
          body: GetBuilder<MainController>(
              init: MainController(),
              builder: (controller) {
                return Stack(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 80,
                          decoration: const BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(15),
                                  bottomRight: Radius.circular(15))),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 45,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        scaffoldKey.currentState?.openDrawer();
                                      },
                                      child: SvgPicture.asset(
                                          AppImages.menuIcon,
                                          height: 12),
                                    ),
                                    Text(
                                      controller.title[controller.currentIndex],
                                      style: const TextStyle(
                                          color: AppColors.whiteColor,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    ),
                                    SizedBox(
                                      child: Stack(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              controller.currentIndex = 3;
                                              controller.update();
                                            },
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 4),
                                              child: SvgPicture.asset(
                                                AppImages.notificationDownIcon,
                                                height: 20,
                                                color:
                                                    controller.currentIndex == 3
                                                        ? AppColors.yellow
                                                        : AppColors.whiteColor,
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 12,
                                            bottom: 5,
                                            child: Container(
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: AppColors.yellow,
                                              ),
                                              child: const Padding(
                                                padding: EdgeInsets.all(3),
                                                child: Text(
                                                  "2",
                                                  style: TextStyle(
                                                      fontSize: 10,
                                                      color:
                                                          AppColors.whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 20),
                              child: Column(
                                children: [
                                  SizedBox(
                                    child: controller
                                        .screens[controller.currentIndex],
                                  ),
                                  const SizedBox(
                                    height: 100,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    Positioned(
                      bottom: 10,
                      right: 0,
                      left: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          alignment: Alignment.center,
                          width: Get.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17),
                              color: AppColors.mainColor),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 9, horizontal: 30),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.homeIcon,
                                          color: controller.currentIndex == 2
                                              ? AppColors.yellow
                                              : AppColors.whiteColor,
                                          height: 15,
                                        ),
                                        Text(
                                          "الرئيسية",
                                          style: TextStyle(
                                              color:
                                                  controller.currentIndex == 2
                                                      ? AppColors.yellow
                                                      : AppColors.whiteColor,
                                              fontFamily: ""),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      controller.currentIndex = 2;
                                      controller.update();
                                    },
                                  ),
                                  InkWell(
                                    child: Column(
                                      children: [
                                        SvgPicture.asset(
                                          AppImages.searchIcon,
                                          color: controller.currentIndex == 0
                                              ? AppColors.yellow
                                              : AppColors.whiteColor,
                                          height: 15,
                                        ),
                                        Text(
                                          "البحث",
                                          style: TextStyle(
                                              color:
                                                  controller.currentIndex == 0
                                                      ? AppColors.yellow
                                                      : AppColors.whiteColor,
                                              fontFamily: ""),
                                        ),
                                      ],
                                    ),
                                    onTap: () {
                                      controller.currentIndex = 0;
                                      controller.update();
                                    },
                                  ),
                                ]),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: FloatingActionButton(
                          elevation: 0,
                          backgroundColor: AppColors.mainColor,
                          onPressed: () {
                            controller.currentIndex = 1;
                            controller.update();
                          },
                          child: Container(
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: AppColors.whiteColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: SvgPicture.asset(
                                  AppImages.addIcon,
                                  height: 23,
                                ),
                              )),
                        ),
                      ),
                    ),
                  ],
                );
              })),
    );
  }
}
