import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import '../homescreen/model/posts_response.dart';

class ReviewRepository {
  Future<PostsResponse> getPosts(Map<String, dynamic> body) async {
    final response = await BaseAPI.get2(ApiUrl.getPaddingDeaths, {});
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return PostsResponse.fromJson(apiResponseModel.toJson());
  }
  Future<ApiResponseModel> approveOrRejectAll(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.approveOrRejectAll, body);
    return ApiResponseModel.fromJson(response.toJson());
  }

  Future<ApiResponseModel> approveOrReject(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.approveOrReject, body);
    return ApiResponseModel.fromJson(response.toJson());
  }

}
