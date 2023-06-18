import 'dart:math';

import 'package:get/get.dart';
import 'package:ramtha/screens/homescreen/model/posts_request.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:flutter/material.dart';
import 'package:ramtha/screens/reviewsscreen/review_repository.dart';

import '../../helper/custom/custom_loading.dart';
import '../../helper/custom/custom_sucsess_dialog.dart';
import '../../helper/custom/custom_toast_massage.dart';

class ReviewController extends GetxController {
  ReviewRepository repository = ReviewRepository();
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

  approveOrRejectAll({String? status}) async {
    loading();
    Map<String, dynamic> body = {"status": status};

    await repository.approveOrRejectAll(body).then((value) async {
      closeLoading();
      if (value.status == '1') {
        getPosts();
        Get.dialog(SuccessDialog(
          massage: status == "1"
              ? " تم القبول ${value.message}"
              : " تم الرفض ${value.message}",
        ));
      } else {
        CustomSnackBar.showCustomSnackBar(
          duration: const Duration(seconds: 1),
          message: value.message,
        );
      }
    });
  }

  approveOrReject({String? status, String? id}) async {
    Map<String, dynamic> body = {"status": status, "post_id": id};
    loading();
    await repository.approveOrReject(body).then((value) async {
      closeLoading();

      if (value.status == '1') {
        getPosts();
        Get.dialog(SuccessDialog(
          massage: status == "1"
              ? " تم القبول ${value.message}"
              : " تم الرفض ${value.message}",
        ));
      } else {
        CustomSnackBar.showCustomSnackBar(
          duration: const Duration(seconds: 1),
          message: "${value.message}",
        );
      }
    });
  }

  @override
  void onInit() {
    // TODO: implement onInit
    getPosts();
    super.onInit();
  }
}
