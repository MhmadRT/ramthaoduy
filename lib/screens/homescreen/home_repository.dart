import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import 'model/posts_response.dart';

class HomeRepository {
  Future<PostsResponse> getPosts(Map<String, dynamic> body) async {
    final response = await BaseAPI.get2(ApiUrl.getDeaths, {});
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return PostsResponse.fromJson(apiResponseModel.toJson());
  }
}
