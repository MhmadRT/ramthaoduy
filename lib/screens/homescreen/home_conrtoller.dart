import 'package:get/get.dart';
import 'package:ramtha/screens/homescreen/home_repository.dart';
import 'package:ramtha/screens/homescreen/model/posts_request.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';

import '../../helper/custom/custom_loading.dart';

class HomeController extends GetxController {
  HomeRepository repository = HomeRepository();
  PostsResponse? posts;
  bool isLoading = true;

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
