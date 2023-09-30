import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/screens/homescreen/home_conrtoller.dart';
import 'package:ramtha/screens/homescreen/widget/edit_user_data_dialog.dart';
import 'package:ramtha/helper/local_storage_helper.dart';
import 'package:ramtha/network/api_urls.dart';
import 'package:ramtha/screens/ratescreen/rate_screen.dart';
import 'package:ramtha/screens/reviewsscreen/reviews_screen.dart';
import 'package:ramtha/constant/app_images.dart';
import '../../helper/custom/topics_dialog.dart';
import '../../helper/custom/user_image.dart';
import '../../helper/custom_no_have_permission.dart';
import '../aboutscreen/about_screen.dart';
import '../changepassword/change_password_screen.dart';
import '../loginscreen/login_screen.dart';
import '../myhistory/history_screen.dart';
import '../notifcation/notifcation_controller.dart';
import 'main_controller.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
        init: MainController(),
        builder: (controller) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: WillPopScope(
              onWillPop: () async {
                return controller.onWillPop();
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
                            controller.isLoadingUserData
                                ? loadingUserData(controller)
                                : Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Get.dialog(Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .center,
                                                children: [
                                                  Dialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    elevation: 0,
                                                    child: UserImage(
                                                      userImage: controller
                                                              .userInfoResponse
                                                              ?.data
                                                              ?.user
                                                              ?.image ??
                                                          "",
                                                      boxFit: BoxFit.cover,
                                                      gender: controller
                                                          .userInfoResponse
                                                          ?.data
                                                          ?.user
                                                          ?.gender,
                                                      radius: 50000,
                                                      size: Get.height / 2,
                                                    ),
                                                  ),
                                                ],
                                              ));
                                            },
                                            child: UserImage(
                                                userImage: controller
                                                        .userInfoResponse
                                                        ?.data
                                                        ?.user
                                                        ?.image ??
                                                    "",
                                                boxFit: BoxFit.cover,
                                                gender: controller
                                                        .userInfoResponse
                                                        ?.data
                                                        ?.user
                                                        ?.gender ??
                                                    "ذكر",
                                                radius: 25,
                                                size: 40),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    controller
                                                            .userInfoResponse
                                                            ?.data
                                                            ?.user
                                                            ?.name ??
                                                        "بدون اسم",
                                                    style: const TextStyle(
                                                        fontSize: 17,
                                                        color: AppColors
                                                            .mainColor,
                                                        fontWeight:
                                                            FontWeight
                                                                .w600)),
                                                Text(
                                                    controller
                                                            .userInfoResponse
                                                            ?.data
                                                            ?.user
                                                            ?.address ??
                                                        "بدون عنوان",
                                                    style: const TextStyle(
                                                        color: AppColors
                                                            .mainColor,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    InkWell(
                                      onTap: controller.isLogin == true
                                          ? () {
                                              Get.dialog(EditUserDataDialog(
                                                user: controller
                                                    .userInfoResponse,
                                              ));
                                            }
                                          : () {
                                              Get.dialog(
                                                  const DialogPermission());
                                            },
                                      child: Column(
                                        children: [
                                          SvgPicture.asset(
                                            AppImages.editIcon,
                                            height: 20,
                                          ),
                                          Text("تعديل",
                                              style: TextStyle(
                                                  color: Colors.grey
                                                      .withOpacity(.5),
                                                  fontWeight:
                                                      FontWeight.normal)),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                            const SizedBox(
                              height: 50,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            Visibility(
                              visible: LocalStorageHelper.checkRole() &&
                                  controller.isLogin == true,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(() => const ReviewsScreen());
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            AppImages.sucsessMassege,
                                            height: 20,
                                            color: AppColors.mainColor),
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
                                ],
                              ),
                            ),
                            Visibility(
                              visible: controller.isLogin == true,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(const ChangePasswordScreen());
                                    },
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          AppImages.posts,
                                          height: 20,
                                          color: AppColors.mainColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text("تغير كلمة المرور",
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
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                controller.share();
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.shareMenuIcon,
                                      height: 20),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("مشاركة التطبيق",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.mainColor,
                                          fontWeight: FontWeight.w600)),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                ],
                              ),
                            ),
                            Visibility(
                              visible: controller.isLogin == true,
                              child: Column(
                                children: [
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Get.to(const MyHistoryScreen());
                                    },
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(AppImages.editIcon,
                                            height: 20,
                                            color: AppColors.mainColor),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        const Text("منشوراتي",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: AppColors.mainColor,
                                                fontWeight: FontWeight.w600)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => AboutScreen());
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.aboutMenuIcon,
                                      height: 20),
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
                                Get.dialog(const SubscribeDialog());
                              },
                              child: Row(
                                children: [
                                  SvgPicture.asset(AppImages.starMenuIcon,
                                      height: 20),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  const Text("الاهتمامات",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: AppColors.mainColor,
                                          fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            const Divider(
                              thickness: 1,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (controller.isLogin == true)
                              GetBuilder<MainController>(builder: (con) {
                                return InkWell(
                                  onTap: () {
                                    makeLogOut();
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
                            if (controller.isLogin == false)
                              GetBuilder<MainController>(builder: (con) {
                                return InkWell(
                                  onTap: () {
                                    LocalStorageHelper.clearCredentials();
                                    Get.offAll(() => const LoginScreen());
                                  },
                                  child: Row(
                                    children: [
                                      RotatedBox(
                                        quarterTurns: 2,
                                        child: SvgPicture.asset(
                                            AppImages.loginMenuIcon,
                                            height: 20,
                                            color: AppColors.mainColor),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      const Text("تسجيل الدخول",
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: AppColors.mainColor,
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
                                  height: 85,
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
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                scaffoldKey.currentState
                                                    ?.openDrawer();
                                              },
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: SvgPicture.asset(
                                                    AppImages.menuIcon,
                                                    height: 12),
                                              ),
                                            ),
                                            Text(
                                              controller.title[
                                                  controller.currentIndex],
                                              style: const TextStyle(
                                                  color: AppColors.whiteColor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            InkWell(
                                              onTap: () async {
                                                controller.currentIndex = 3;
                                                controller.update();

                                                var homeController =
                                                    Get.find<HomeController>();
                                                homeController
                                                    .notificationController
                                                    .pageNumber = 1;
                                                homeController
                                                    .notificationController
                                                    .getNotificationsResponse
                                                    .data
                                                    ?.clear();
                                                homeController
                                                    .notificationController
                                                    .update();
                                                await homeController
                                                    .notificationController
                                                    .getNotification();
                                              },
                                              child: Stack(
                                                children: [
                                                  SizedBox(
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: Stack(
                                                        children: [
                                                          Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    horizontal:
                                                                        4),
                                                            child: SvgPicture
                                                                .asset(
                                                              AppImages
                                                                  .notificationDownIcon,
                                                              height: 20,
                                                              color: controller
                                                                          .currentIndex ==
                                                                      3
                                                                  ? AppColors
                                                                      .yellow
                                                                  : AppColors
                                                                      .whiteColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Visibility(
                                                    visible: (controller
                                                                .getNumberNotReaded
                                                                .data
                                                                ?.count ??
                                                            0) >
                                                        0,
                                                    child: Positioned(
                                                      right: 7,
                                                      child: Container(
                                                        decoration:
                                                            const BoxDecoration(
                                                                color: AppColors
                                                                    .yellow,
                                                                shape: BoxShape
                                                                    .circle),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(4.0),
                                                          child: Text(
                                                            controller
                                                                    .getNumberNotReaded
                                                                    .data
                                                                    ?.count
                                                                    .toString() ??
                                                                "",
                                                            style:
                                                                const TextStyle(
                                                              fontFamily: "",
                                                              fontSize: 8.5,
                                                              color: AppColors
                                                                  .whiteColor,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                            ),
                                                          ),
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
                                GetBuilder<HomeController>(
                                    init: HomeController(),
                                    builder: (homeController) {
                                      return Expanded(
                                        child: RefreshIndicator(
                                            onRefresh: () async {
                                              if (controller.currentIndex ==
                                                  2) {
                                                homeController.pageNumber = 1;
                                                homeController
                                                    .posts.posts?.posts
                                                    ?.clear();
                                                homeController.update();
                                                await homeController.getPosts();
                                              }
                                              if (controller.currentIndex ==
                                                  3) {
                                                homeController
                                                    .notificationController
                                                    .pageNumber = 1;
                                                homeController
                                                    .notificationController
                                                    .getNotificationsResponse
                                                    .data
                                                    ?.clear();
                                                homeController
                                                    .notificationController
                                                    .update();
                                                await homeController
                                                    .notificationController
                                                    .getNotification();
                                              }
                                            },
                                            child: SingleChildScrollView(
                                              controller: (controller
                                                          .currentIndex ==
                                                      2)
                                                  ? homeController
                                                      .scrollController
                                                  : controller.currentIndex == 3
                                                      ? homeController
                                                          .notificationController
                                                          .scrollController
                                                      : null,
                                              physics:
                                                  const BouncingScrollPhysics(),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      child: controller.screens[
                                                          controller
                                                              .currentIndex],
                                                    ),
                                                    const SizedBox(
                                                      height: 100,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            )),
                                      );
                                    })
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
                                                  color: controller
                                                              .currentIndex ==
                                                          2
                                                      ? AppColors.yellow
                                                      : AppColors.whiteColor,
                                                  height: 15,
                                                ),
                                                Text(
                                                  "الرئيسية",
                                                  style: TextStyle(
                                                      color: controller
                                                                  .currentIndex ==
                                                              2
                                                          ? AppColors.yellow
                                                          : AppColors
                                                              .whiteColor,
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
                                                  AppImages.services,
                                                  color: controller
                                                              .currentIndex ==
                                                          0
                                                      ? AppColors.yellow
                                                      : AppColors.whiteColor,
                                                  height: 16,
                                                ),
                                                Text(
                                                  "خدمات",
                                                  style: TextStyle(
                                                      color: controller
                                                                  .currentIndex ==
                                                              0
                                                          ? AppColors.yellow
                                                          : AppColors
                                                              .whiteColor,
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
                                  onPressed: controller.isLogin == true
                                      ? () {
                                          controller.currentIndex = 1;
                                          controller.update();
                                        }
                                      : () {
                                          Get.dialog(const DialogPermission());
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
            ),
          );
        });
  }

  Row loadingUserData(MainController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomLoading(
                height: 40,
                width: 40,
                radius: 1000,
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomLoading(
                      height: 10,
                      width: Get.width / 3,
                      radius: 5,
                    ),
                    const SizedBox(
                      height: 12,
                    ),
                    CustomLoading(
                      height: 10,
                      width: Get.width / 2.5,
                      radius: 5,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Column(
          children: [
            CustomLoading(
              height: 20,
              width: 20,
              radius: 2,
            ),
            SizedBox(
              height: 5,
            ),
            CustomLoading(
              height: 10,
              width: 50,
              radius: 5,
            ),
          ],
        )
      ],
    );
  }
}
