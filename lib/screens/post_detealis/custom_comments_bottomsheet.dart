import 'package:cached_network_image/cached_network_image.dart';
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
          return Container(
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
                          : commentsWidget(controller.commentPosts),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Expanded(
                            child: CustomTextField(

                          showTitle: false,
                          hintText: 'أضف تعليق',

                        )),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.mainColor,
                            borderRadius: BorderRadius.circular(12)
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                                child: Icon(
                              Icons.send,
                              color: AppColors.whiteColor,
                            )),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ));
        });
  }

  loading() {
    return ListView.builder(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: 10,
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
                          Expanded(
                              child: CustomLoading(
                            height: 10,
                            width: 150,
                          )),
                          CustomLoading(height: 10, width: 20),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: CustomLoading(
                            height: 10,
                          )),
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

  commentsWidget(CommentsResponse? commentsResponse) {
    return (commentsResponse?.data?.comments?.isEmpty ?? true)
        ? const Center(child: Text('Not Found Data'))
        : ListView.builder(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: commentsResponse?.data?.comments?.length,
            itemBuilder: (context, index) {
              var comment = commentsResponse?.data?.comments?[index];
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    UserImage(
                        size: 50,
                        gender: comment?.username,
                        userImage: comment?.username),
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
                                    fontWeight: FontWeight.bold, fontSize: 17),
                              )),
                              Text(
                                comment?.createdAt ?? "",
                                style: const TextStyle(fontSize: 13),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: Text(comment?.content ?? "")),
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
}
