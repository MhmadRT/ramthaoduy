import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/screens/reviewsscreen/review_controller.dart';
import '../../helper/custom/custom_button.dart';
import '../../helper/custom/custom_card_info.dart';
import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/no_data_widget.dart';
import '../homescreen/model/posts_response.dart';
import '../post_detealis/post_detealis_screen.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(
        init: ReviewController(),
        builder: (controller) {
          return Scaffold(
            body: Stack(
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
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Get.back();
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: const Icon(Icons.arrow_back_ios,
                                        color: AppColors.whiteColor, size: 15),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "منشورات تحتاج موافقة",
                                    style: TextStyle(
                                        color: AppColors.whiteColor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.getPosts();
                                  },
                                  child: const Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(4.0),
                                        child: Icon(Icons.refresh,
                                            color: AppColors.whiteColor),
                                      ),
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
                      child: RefreshIndicator(
                        onRefresh: () async {
                          await controller.getPosts();
                        },
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, bottom: 100, top: 10),
                            child: Column(
                              children: [
                                if (controller.isLoading) loading(),
                                posts(
                                    controller.posts?.posts ??
                                        PostsModel(posts: []),
                                    controller),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: ((controller.posts?.posts?.posts?.length ?? 0) >= 2),
                  child: Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomButton(
                                color: AppColors.red,
                                title: "رفض الكل",
                                colorTitle: AppColors.whiteColor,
                                height: 40,
                                borderRadius: 15,
                                pressed: () {
                                  Get.dialog(Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildQuestionDialog(controller, 2),
                                    ],
                                  ));
                                },
                                width: Get.width / 2.3),
                            const SizedBox(
                              width: 10,
                            ),
                            CustomButton(
                                color: AppColors.mainColor,
                                title: "قبول الكل",
                                colorTitle: AppColors.whiteColor,
                                height: 40,
                                borderRadius: 15,
                                pressed: () {
                                  Get.dialog(Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      _buildQuestionDialog(controller, 1),
                                    ],
                                  ));
                                },
                                width: Get.width / 2.3),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }

  Dialog _buildQuestionDialog(
      ReviewController controller, int approveOrReject) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12), color: Colors.white),
              child: Column(children: [
                const Text(
                  "هل انت متاكد من هذه العملية",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppColors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text("اغلاق",
                              style: TextStyle(color: AppColors.whiteColor)),
                        ),
                      ),
                    ),
                    const Expanded(child: SizedBox()),
                    InkWell(
                      onTap: () {
                        if (approveOrReject == 2) {
                          controller.approveOrRejectAll(
                            status: "2",
                          );
                        } else {
                          controller.approveOrRejectAll(
                            status: "1",
                          );
                        }

                        Get.back();
                      },
                      child: Container(
                        height: 40,
                        width: 100,
                        decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text("تأكيد",
                              style: TextStyle(color: AppColors.whiteColor)),
                        ),
                      ),
                    )
                  ],
                )
              ]),
            ),
          ),
        ],
      ),
    );
  }

  loading() {
    return Column(
      children: [
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: CustomLoading(
                  height: 120,
                  width: Get.width,
                ),
              );
            }),
      ],
    );
  }

  posts(PostsModel postsModel, ReviewController controller) {
    return ((postsModel.posts?.length ?? 0) > 0) &&
            controller.isLoading == false
        ? ListView.builder(
            padding: EdgeInsets.zero,
            controller: controller.scrollController,
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: postsModel.posts?.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  InkWell(
                    onTap: () {
                      Get.to(
                          PostDetailsScreen(
                            post: postsModel.posts![index],
                          ),
                          transition: Transition.rightToLeftWithFade);
                    },
                    child: CustomCardInfo(
                      isReview: true,
                      post: postsModel.posts![index],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomButton(
                          color: AppColors.red,
                          title: "رفض",
                          colorTitle: AppColors.whiteColor,
                          height: 40,
                          pressed: () {
                            controller.approveOrReject(
                                status: "2",
                                id: postsModel.posts![index].id.toString());
                          },
                          width: Get.width / 2.3),
                      const SizedBox(
                        width: 10,
                      ),
                      CustomButton(
                          color: AppColors.mainColor,
                          title: " قبول",
                          colorTitle: AppColors.whiteColor,
                          height: 40,
                          pressed: () {
                            controller.approveOrReject(
                                status: "1",
                                id: postsModel.posts![index].id.toString());
                          },
                          width: Get.width / 2.3),
                    ],
                  ),
                ],
              );
            })
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height / 3.5,
              ),
              const NoDataWidget(
                title: "لا يوجد منوشرات تحتاج موافقة",
              ),
            ],
          ));
  }
}
