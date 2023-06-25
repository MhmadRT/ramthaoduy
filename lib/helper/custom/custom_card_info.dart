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

  const CustomCardInfo({
    super.key,
    required this.post,
    required this.isReview,
  });

  @override
  Widget build(BuildContext context) {
   bool? isLogin=Get.find<MainController>().isLogin;
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
                          userImage: '',
                          gender: post.gender,
                          radius: 25,
                          size: 40),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(post.nameOfRequester ?? ""),
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
                  Text(
                    post.deadName ?? "",
                    style: const TextStyle(
                        color: AppColors.mainColor,
                        fontSize: 15,
                        fontWeight: FontWeight.w600),
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
                          InkWell(
                            onTap: isLogin??false?() {
                              Get.bottomSheet(
                                  CustomCommentsBottomSheet(
                                    post: post,
                                  ),
                                  isScrollControlled: true);
                            }:() {
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
                                      if(post.numberOfComments!=0)
                                      Text("${post.numberOfComments}",
                                          style: TextStyle(color: Colors.grey)),
                                      const SizedBox(width: 5,),
                                      const Text("تعليق",
                                        style: TextStyle(color: Colors.grey)),
                                    ],
                                  ),
                              ],
                            ),
                          ),
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
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
