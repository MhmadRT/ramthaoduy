import 'package:get/get.dart';
import 'package:ramtha/helper/custom/custom_loading.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:ramtha/screens/post_detealis/post_detealis_screen.dart';
import 'package:ramtha/screens/post_detealis/post_repository.dart';

class FunctionsHelper {
  static Future<void> goToPostByID({required String postID}) async {
    loading();

    Post? post = await PostRepository().getPostDetailsByID(postID);
    closeLoading();
    if (post != null) {
      Get.to(PostDetailsScreen(post: post));
    }
  }
}
