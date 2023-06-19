import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import '../homescreen/model/posts_response.dart';

class SearchRepository {
  Future<PostsResponse> getPostsFromSearch(Map<String, dynamic> body, {required String search}) async {
    final response = await BaseAPI.get2(ApiUrl.getDeaths, {"search": search});
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return PostsResponse.fromJson(apiResponseModel.toJson());
  }
}
