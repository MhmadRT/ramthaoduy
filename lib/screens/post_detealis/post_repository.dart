import 'package:ramtha/screens/homescreen/model/posts_response.dart';

import '../../network/api_urls.dart';
import '../../network/base_api.dart';

class PostRepository {
  Future<Post?> getPostDetailsByID(String id) async {
    try {
      final response = await BaseAPI.get2(ApiUrl.getPostById, {"post_id": id});
      return Post.fromJson(response.toJson()['data']);
    } catch (e) {
      return null;
    }
  }
}
