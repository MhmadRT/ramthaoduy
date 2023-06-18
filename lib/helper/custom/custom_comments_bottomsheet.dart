
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:ramtha/screens/post_detealis/post_controller.dart';

import '../../constant/app_colors.dart';
import '../../screens/homescreen/home_conrtoller.dart';
import '../../screens/homescreen/model/comments_response.dart';
import 'custom_loading.dart';

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
                    controller.isLoadingComment == false
                        ? ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: const BouncingScrollPhysics(),
                            shrinkWrap: true,
                            itemCount:
                                controller.commentPosts?.data?.comments?.length,
                            itemBuilder: (context, index) {
                              Comments? com = controller
                                  .commentPosts?.data?.comments?[index];
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        maxRadius: 20,
                                        backgroundImage: NetworkImage(
                                            'https://www.sayidaty.net/sites/default/files/styles/900_scale/public/2019/12/03/6145006-1029464460.jpg'),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        com?.username ?? "",
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            color: AppColors
                                                                .mainColor,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w700))),
                                                Text(com?.createdAt ?? '',
                                                    style: TextStyle(
                                                        fontSize: 13,
                                                        color: Colors
                                                            .grey.shade500)),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                Expanded(
                                                    child: Text(
                                                        com?.content ?? "")),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            })
                        : loading(),
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
          return Column(
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
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomLoading(
                    height: 20,
                    width: 20,
                  ),
                  SizedBox(
                    width: 10,
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
            ],
          );
        });
  }
}
