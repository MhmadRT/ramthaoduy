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
      child: Container(
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.grey.shade50),
              BoxShadow(color: Colors.grey.shade100),
              BoxShadow(color: Colors.grey.shade200),
              BoxShadow(color: Colors.grey.shade300),
              BoxShadow(color: Colors.grey.shade400),
            ],
            color: AppColors.infoCardColor,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.only(top: 3, bottom: 0, right: 0, left: 0),
          child: SizedBox(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          UserImage(
                              userImage: post.image,
                              gender: post.gender,
                              size: 150),
                          Opacity(
                            opacity: .8,
                            child: Image.asset(AppImages.blackLine,
                                height: 40, width: 45),
                          ),
                        ],
                      ),
                      Expanded(
                        child: SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
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
                              Text(
                                post.deadName ?? "",
                                style: const TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                ConstVars.timeAgo(post.createdDate),
                                style: const TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                '${post.ageInYears.toString() ?? ""} عام',
                                style: const TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
                              ),
                              Text(
                                post.city ?? "",
                                style: const TextStyle(
                                    color: AppColors.mainColor,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600),
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
                        )),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                if (!isReview)
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("التفاصيل"),
                        const SizedBox(
                          width: 10,
                        ),
                        SvgPicture.asset(
                          height: 7,
                          AppImages.dropDownIcon,
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
