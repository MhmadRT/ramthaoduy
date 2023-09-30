import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/screens/homescreen/home_repository.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../helper/custom/custom_toast_massage.dart';
import '../homescreen/home_conrtoller.dart';
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

  void launchPhoneDialer(String phoneNumber) async {
    final url = 'tel:$phoneNumber';

    await launchUrl(Uri.parse(url));
  }

  void openSms(String phoneNumber, String defaultText) async {
    final smsUri = 'sms:$phoneNumber?body=${Uri.encodeComponent(defaultText)}';

    if (await launchUrl(Uri.parse(smsUri))) {
      await launchUrl(Uri.parse(smsUri));
    } else {
      throw 'Could not launch SMS app.';
    }
  }

  void openWhatsApp(int phoneNumber, String defaultText) async {
    var whatsappUrl = "whatsapp://send?phone=$phoneNumber";
    if (await launchUrl(Uri.parse(whatsappUrl))) {
      await launchUrl(Uri.parse(whatsappUrl));
    } else {
      throw 'Could not launch WhatsApp.';
    }
  }

  launchWhatsApp() async {
    int phone = 0785164327;
    var whatsappUrl = "whatsapp://send?phone=$phone";
    await launchUrl(Uri.parse(whatsappUrl));
  }

  PostController(this.post);

  getComment() async {
    isLoadingComment = true;
    update();
    commentPosts = await repository.getComment(postId: post.id.toString());
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
      isLoadingComment=true;
      Map<String, dynamic> body = {
        "content": comment.text,
        "post_id": post.id.toString(),
      };
      await repository.addComment(body).then((value) async {
        isLoadingComment=false;
        FocusScope.of(Get.context!).unfocus();
        if (value.status == '1') {
          await getComment();
          comment.clear();
          await Future.delayed(Duration(seconds: 1));
          // _scrollDown();
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

  deleteComment(String? commentId) async {
    isLoadingComment=true;
    Map<String, dynamic> body = {
      "comment_id": commentId,
    };
    await repository.deleteComment(body).then((value) async {
      isLoadingComment=false;
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
