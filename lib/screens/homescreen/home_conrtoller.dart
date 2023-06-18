import 'package:get/get.dart';
import 'package:ramtha/constant/app_colors.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/screens/homescreen/home_repository.dart';
import 'package:ramtha/screens/homescreen/model/posts_request.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:flutter/material.dart';

import '../../helper/custom/custom_comments_bottomsheet.dart';
import '../../helper/custom/custom_toast_massage.dart';
import 'model/comments_response.dart';

class HomeController extends GetxController {
  HomeRepository repository = HomeRepository();
  PostsResponse? posts;
  bool isLoading = true;
  ScrollController? scrollController;

  getPosts() async {
    isLoading = true;
    update();
    PostsRequest postsRequest = PostsRequest();
    posts = await repository.getPosts(postsRequest.toJson());
    isLoading = false;
    update();
  }


  @override
  void onInit() {
    // TODO: implement onInit
    getPosts();
    super.onInit();
  }
}
