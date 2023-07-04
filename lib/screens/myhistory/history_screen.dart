import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/myhistory/history_controller.dart';
import '../../constant/app_colors.dart';
import '../../constant/app_images.dart';
import '../../helper/custom/custom_card_info.dart';
import '../../helper/custom/custom_loading.dart';
import '../homescreen/model/posts_response.dart';

class MyHistoryScreen extends StatelessWidget {
  const MyHistoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<HistoryController>(
          init: HistoryController(),
          builder: (controller) {
            return Column(
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
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Get.back();
                              },
                              child: const Icon(Icons.arrow_back_ios,
                                  color: AppColors.whiteColor, size: 15),
                            ),
                            Container(
                              alignment: Alignment.center,
                              child: const Text(
                                "منشوراتي",
                                style: TextStyle(
                                    color: AppColors.whiteColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 17),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                posts(controller.postsResponse?.posts ?? PostsModel(posts: []),
                    controller),
              ],
            );
          }),
    );
  }

  loading() {
    return Expanded(
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: 2,
          padding: const EdgeInsets.all(20),
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
                        const CustomLoading(
                          radius: 10,
                          height: 13,
                          width: 80,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomLoading(
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
                                    height: 40,
                                    width: 45,
                                    color: Colors.black12),
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
          }),
    );
  }

  posts(PostsModel postsModel, HistoryController controller) {
    return Expanded(
      child: ListView.builder(
          padding: const EdgeInsets.all(20),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          itemCount: controller.isLoading
              ? (postsModel.posts?.length ?? 0) + 1
              : postsModel.posts?.length,
          itemBuilder: (context, index) {
            if (controller.isLoading && index == postsModel.posts?.length) {
              return loading();
            }
            return CustomCardInfo(
              isReview: true,
              showStatus:true,
              post: postsModel.posts![index],
            );
          }),
    );
  }
}
