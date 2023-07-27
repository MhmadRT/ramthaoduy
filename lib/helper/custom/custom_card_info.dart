import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/helper/custom/user_image.dart';
import 'package:ramtha/network/api_urls.dart';
import 'package:ramtha/screens/homescreen/home_conrtoller.dart';
import 'package:ramtha/screens/mainscreen/main_controller.dart';

import '../../constant/const_var.dart';
import '../../screens/homescreen/model/posts_response.dart';
import '../../screens/post_detealis/post_detealis_screen.dart';
import '../custom_no_have_permission.dart';
import 'custom_button.dart';
import '../../screens/post_detealis/custom_comments_bottomsheet.dart';

class CustomCardInfo extends StatelessWidget {
  final Post post;
  final bool isReview;
  final bool? showStatus;

  const CustomCardInfo({
    super.key,
    required this.post,
    this.showStatus,
    required this.isReview,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 0, right: 0, left: 0),
        child: InkWell(
          onTap: () {
            Get.to(PostDetailsScreen(post: post));
          },
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.cardColor),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      UserImage(
                          userImage: post.userImage,
                          gender: post.genderOfRequester == 1 ? "ذكر" : "انثى",
                          radius: 5000,
                          boxFit: BoxFit.cover,
                          // boxFit: BoxFit.cover,
                          size: 40),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.nameOfRequester ?? "",

                            ),
                            Visibility(
                              visible: GetUtils.isDateTime(
                                  post.createdDate?.toIso8601String() ?? ""),
                              child: Text(
                                ConstVars.format.format(post.createdDate!),
                                style: TextStyle(
                                  color: AppColors.mainColor.withOpacity(.5),
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            post.city ?? "",
                            style: const TextStyle(
                                color: AppColors.mainColor,
                                fontSize: 15,
                                fontWeight: FontWeight.w600),
                          ),
                          const Icon(
                            Icons.location_on_rounded,
                            color: AppColors.red,
                            size: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Text(
                        post.gender=="ذكر"?  "الفقيد :":  "الفقيدة :",
                        style: const TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        post.deadName ?? "",
                        style: const TextStyle(
                            color: AppColors.mainColor,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  Text(
                    post.buryDescription ?? "",
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: Get.width,
                    height: 200,
                    child: Stack(
                      children: [
                        Hero(
                          tag: post.id.toString(),
                          child: UserImage(
                              radius: 10,
                              userImage: post.image,
                              gender: post.gender,
                              size: Get.width),
                        ),
                        Opacity(
                          opacity: .8,
                          child: Image.asset(AppImages.blackLine,
                              height: 40, width: 45),
                        ),
                      ],
                    ),
                  ),
                  if (!isReview)
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GetBuilder<MainController>(builder: (controller) {
                            return InkWell(
                              onTap: controller.isLogin ?? false
                                  ? () {
                                      Get.bottomSheet(
                                          CustomCommentsBottomSheet(
                                            post: post,
                                          ),
                                          isScrollControlled: true);
                                    }
                                  : () {
                                      Get.dialog(const DialogPermission());
                                    },
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                    AppImages.commentIcon,
                                    height: 17,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Row(
                                    children: [
                                      if (post.numberOfComments != 0)
                                        Text("${post.numberOfComments}",
                                            style:
                                                TextStyle(color: Colors.grey)),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      const Text("تعليق",
                                          style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          }),
                          const Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.share,
                                color: AppColors.mainColor,
                                size: 17,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Text("مشاركة",
                                  style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  Visibility(
                      visible: showStatus == true && isReview == true,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 20,
                              width: 20,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: statusColor(),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(status()),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String status() {
    switch (post.status) {
      case 0:
        return 'قيد المراجعه';
      case 1:
        return 'مقبول';
      case 2:
        return 'مرفوض';
      default:
        return '';
    }
  }

  Color statusColor() {
    switch (post.status) {
      case 0:
        return AppColors.yellow;
      case 1:
        return Colors.green;
      case 2:
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}
