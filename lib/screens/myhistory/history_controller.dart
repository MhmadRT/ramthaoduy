import 'package:get/get.dart';
import 'package:ramtha/screens/homescreen/model/posts_response.dart';
import 'package:ramtha/screens/myhistory/history_repository.dart';

import '../homescreen/model/posts_request.dart';

class HistoryController extends GetxController {
  bool isLoading = true;
  PostsResponse? postsResponse;

  @override
  void onInit() {
    // TODO: implement onInit
    getMyHistory();
    super.onInit();
  }

  getMyHistory() async {
    isLoading = true;
    update();

    postsResponse = await HistoryRepository().getHistory({});
    isLoading = false;
    update();
  }
}
