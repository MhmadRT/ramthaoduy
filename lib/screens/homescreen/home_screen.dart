import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/constant/app_images.dart';
import 'package:ramtha/helper/custom/custom_card_info.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/screens/homescreen/home_conrtoller.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:ramtha/screens/homescreen/widget/filtter_bottom_sheet.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "الاحدث",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainColor),
                  ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(const FilterBottomSheet(),
                          isScrollControlled: true);
                    },
                    child: Row(
                      children: [
                        const Text(
                          "فلترة",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.mainColor),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        SvgPicture.asset(
                          AppImages.filterIcon,
                          height: 20,
                        )
                      ],
                    ),
                  )
                ],
              ),
              posts(
                  controller.posts.posts ?? PostsModel(posts: []), controller),
            ],
          );
        });
  }

  loading() {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: 2,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 3, bottom: 0, right: 0, left: 0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: AppColors.cardColor),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          CustomLoading(
                            radius: 100,
                            height: 40,
                            width: 40,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomLoading(
                                  radius: 10,
                                  height: 10,
                                  width: 100,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                CustomLoading(
                                  radius: 10,
                                  height: 7,
                                  width: 50,
                                ),
                              ],
                            ),
                          ),
                          Row(
                            children: [
                              CustomLoading(
                                radius: 10,
                                height: 10,
                                width: 40,
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              CustomLoading(
                                radius: 10,
                                height: 10,
                                width: 10,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomLoading(
                        radius: 10,
                        height: 13,
                        width: 80,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomLoading(
                        radius: 10,
                        height: 8,
                        width: 150,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: Get.width,
                        height: 200,
                        child: Stack(
                          children: [
                            CustomLoading(
                              radius: 10,
                              height: 200,
                              width: Get.width,
                            ),
                            Opacity(
                              opacity: .8,
                              child: Image.asset(AppImages.blackLine,
                                  height: 40, width: 45, color: Colors.black12),
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
        });
  }

  posts(PostsModel postsModel, HomeController controller) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.isLoading
            ? (postsModel.posts?.length ?? 0) + 1
            : postsModel.posts?.length,
        itemBuilder: (context, index) {
          if (controller.isLoading && index == postsModel.posts?.length) {
            return loading();
          }
          return CustomCardInfo(
            isReview: false,
            post: postsModel.posts![index],
          );
        });
  }
}
