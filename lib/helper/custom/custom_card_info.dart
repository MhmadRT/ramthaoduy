import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/network/api_urls.dart';

import '../../constant/const_var.dart';
import '../../screens/homescreen/model/posts_response.dart';

class CustomCardInfo extends StatelessWidget {
  final Post post;

  const CustomCardInfo({super.key, required this.post});

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
                  padding: const EdgeInsets.all(3.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: Get.width / 2.5,
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: (post.image?.isEmpty ?? true)
                                  ? post.gender == "1"
                                      ? Image.asset(
                                          fit: BoxFit.fitHeight,
                                          height: 150,
                                          AppImages.male)
                                      : Image.asset(
                                          fit: BoxFit.fitHeight,
                                          height: 150,
                                          AppImages.female)
                                  : SizedBox(
                                      height: 150,
                                      width: 150,
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            ApiUrl.baseUrl + (post.image ?? ""),
                                        progressIndicatorBuilder:
                                            (context, url, downloadProgress) =>
                                                Center(
                                          child: CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                        ),
                                        errorWidget: (context, url, error) =>
                                            const Center(
                                                child: Icon(Icons.error)),
                                      ),
                                    ),
                            ),
                            Opacity(
                              opacity: .8,
                              child: Image.asset(AppImages.blackLine,
                                  height: 40, width: 45),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                            child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
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
                                      const Text(" 2 تعليق",
                                          style: TextStyle(color: Colors.grey)),
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
                                          style: TextStyle(color: Colors.grey)),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
