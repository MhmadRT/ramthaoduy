import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/helper/custom/user_image.dart';
import 'package:ramtha/network/api_urls.dart';

import '../../constant/const_var.dart';
import '../../screens/homescreen/model/posts_response.dart';
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.only(top: 3, bottom: 0, right: 0, left: 0),
        child: Container(
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
                  const SizedBox(width: 20,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(post.nameOfRequester??""),
                        Visibility(
                          visible: GetUtils.isDateTime(
                              post.createdDate?.toIso8601String() ??
                                  ""),
                          child: Text(
                            ConstVars.format
                                .format(post.createdDate!),
                            style: TextStyle(
                              color:
                              AppColors.mainColor.withOpacity(.5),
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
                      ), const Icon(Icons.location_on_rounded,color: AppColors.red,size: 16,),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Text(
                post.deadName ?? "",
                style: const TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              ),

              SizedBox(
                width: Get.width,
                height: 200,
                child: Stack(
                  children: [
                    UserImage(
                        userImage: post.image,
                        gender: post.gender,
                        size: Get.width),
                    Opacity(
                      opacity: .8,
                      child: Image.asset(AppImages.blackLine,
                          height: 40, width: 45),
                    ),
                  ],
                ),
              ),
              Text(
                post.buryDescription ?? "",
                style: const TextStyle(
                    color: AppColors.mainColor,
                    fontSize: 12,
                    fontWeight: FontWeight.normal),
              ),
              if (!isReview)
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          AppImages.commentIcon,
                          height: 17,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        InkWell(
                          onTap: () {
                            Get.bottomSheet(
                                CustomCommentsBottomSheet(
                                    post: post));
                          },
                          child: const Text(" 2 تعليق",
                              style: TextStyle(
                                  color: Colors.grey)),
                        ),
                      ],
                    ),
                    const Row(
                      crossAxisAlignment:
                      CrossAxisAlignment.center,
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
                            style:
                            TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }
}
