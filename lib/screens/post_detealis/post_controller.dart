import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/homescreen/home_repository.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';

import '../../helper/custom/custom_toast_massage.dart';
import '../homescreen/model/comments_response.dart';

class PostController extends GetxController {
  bool isLoadingComment = true;
  CommentsResponse? commentPosts;
  HomeRepository repository = HomeRepository();
  final Post post;
  TextEditingController comment = TextEditingController();

  @override
  void onInit() {
    getComment();
    super.onInit();
  }

  PostController(this.post);

  getComment() async {
    isLoadingComment = true;
    update();
    commentPosts = await repository.getComment(postId: '9');
    isLoadingComment = false;
    update();
  }
}
