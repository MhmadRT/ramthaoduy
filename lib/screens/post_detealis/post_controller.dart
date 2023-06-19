import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
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
  final ScrollController scrollController = ScrollController();

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

  void _scrollDown() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.ease,
    );
    update();
  }

  addComment() async {
    if (comment.text.isNotEmpty) {
      loading();
      Map<String, dynamic> body = {
        "content": comment.text,
        "post_id": "9",
      };
      await repository.addComment(body).then((value) async {
        closeLoading();
        if (value.status == '1') {
          await getComment();
          comment.clear() ;
          await Future.delayed(Duration(seconds: 1));
          _scrollDown();
        } else {
          CustomSnackBar.showCustomSnackBar(
            duration: const Duration(seconds: 1),
            message: value.message,
          );
        }
      });
      update();
    }
  }

  deleteComment(String ?commentId) async {
    loading();
    Map<String, dynamic> body = {
      "comment_id": commentId,
    };
    await repository.deleteComment(body).then((value) async {
      closeLoading();
      if (value.status == '1') {
        await getComment();
      } else {
        CustomSnackBar.showCustomSnackBar(
          duration: const Duration(seconds: 1),
          message: value.message,
        );
      }
    });
    update();
  }
}
