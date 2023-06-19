import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ramtha/screens/searchscreen/search_repository.dart';

import '../homescreen/model/posts_request.dart';
import '../homescreen/model/posts_response.dart';

class SearchScreenController  extends GetxController{
  SearchRepository searchRepository =SearchRepository();
  PostsResponse? posts;
  bool isLoading = false;
  TextEditingController searchController =TextEditingController();
  getPostsFromSearch() async {
    isLoading = true;
    update();
    PostsRequest postsRequest = PostsRequest();
    posts = await searchRepository.getPostsFromSearch(postsRequest.toJson(),search:searchController.text );
    isLoading = false;
    update();
  }
}