import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_card_info.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/screens/homescreen/home_conrtoller.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) {
          return Column(
            children: [
              if (controller.isLoading) loading(),
              posts(controller.posts?.posts ?? PostsModel(posts: [])),
            ],
          );
        });
  }

  loading() {
    return ListView.builder(
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
        });
  }

  posts(PostsModel postsModel) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: postsModel.posts?.length,
        itemBuilder: (context, index) {
          return CustomCardInfo(
            post: postsModel.posts![index],
          );
        });
  }
}
