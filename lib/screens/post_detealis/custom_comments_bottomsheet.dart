import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_text_feild.dart';
import 'package:ramtha/helper/custom/user_image.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:ramtha/screens/post_detealis/post_controller.dart';

import '../../constant/app_colors.dart';
import '../homescreen/home_conrtoller.dart';
import '../homescreen/model/comments_response.dart';
import '../../helper/custom/custom_loading.dart';

class CustomCommentsBottomSheet extends StatelessWidget {
  final Post post;

  const CustomCommentsBottomSheet({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostController>(
        init: PostController(post),
        builder: (controller) {
          return Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Container(
                decoration: const BoxDecoration(
                    color: AppColors.whiteColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 100,
                            height: 5,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20)),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Expanded(
                        child: controller.isLoadingComment
                            ? loading()
                            : commentsWidget(
                                controller.commentPosts, controller),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: CustomTextField(
                                maxLines: 1,
                            showTitle: false,
                            hintText: 'أضف تعليق',
                            controller: controller.comment,
                            onchange: (v) {
                              controller.update();
                            },
                          )),
                          const SizedBox(
                            width: 20,
                          ),
                          InkWell(
                            onTap: controller.comment.text.isNotEmpty
                                ? () {
                                    controller.addComment();
                                  }
                                : null,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: controller.comment.text.isNotEmpty
                                      ? AppColors.mainColor
                                      : AppColors.mainColor.withOpacity(.5),
                                  borderRadius: BorderRadius.circular(12)),
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Center(
                                    child: Icon(
                                  Icons.send,
                                  color: AppColors.whiteColor,
                                )),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )),
          );
        });
  }

  loading() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 7,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomLoading(
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CustomLoading(
                            height: 10,
                            width: 100,
                          ),
                          Expanded(child: SizedBox()),
                          CustomLoading(height: 7, width: 20),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomLoading(
                            height: 5,
                          )),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          CustomLoading(
                            height: 5,
                            width: 40,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Row(
                        children: [
                          CustomLoading(
                            height: 5,
                            width: 20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  commentsWidget(
      CommentsResponse? commentsResponse, PostController controller) {
    return (commentsResponse?.data?.comments?.isEmpty ?? true)
        ? const Center(child: Text('لا يوجد تعليقات'))
        : ListView.builder(
            controller: controller.scrollController,
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: commentsResponse?.data?.comments?.length,
            itemBuilder: (context, index) {
              var comment = commentsResponse?.data?.comments?[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Dismissible(
                  dragStartBehavior: DragStartBehavior.start,
                  background: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: AppColors.red,

                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.clear,
                            color: AppColors.whiteColor,
                          ),
                          Icon(
                            Icons.clear,
                            color: AppColors.whiteColor,
                          )
                        ],
                      ),
                    ),
                  ),
                  key: Key(DateTime.now().toIso8601String()),
                  onDismissed: (_) =>
                      controller.deleteComment(comment?.id.toString()),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color:AppColors.cardColor,

                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          UserImage(
                              userImage: comment?.image,
                              gender: comment?.gender==1?"ذكر":"انثى",
                              radius: 5000,
                              boxFit: BoxFit.cover,isComment: true,
                              size: 40),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(
                                      comment?.username ?? "",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 17),
                                    )),
                                    Column(
                                      children: [
                                        Text(
                                          comment?.createdAt ?? "",
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                        child: Text(comment?.content ?? "")),
                                  ],
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
}
