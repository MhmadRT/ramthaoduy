import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import 'model/comments_response.dart';
import 'model/posts_response.dart';

class HomeRepository {
  Future<PostsResponse> getPosts(Map<String, dynamic> body) async {
    final response = await BaseAPI.get2(ApiUrl.getDeaths, {});
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return PostsResponse.fromJson(apiResponseModel.toJson());
  }

  Future<CommentsResponse> getComment({required String postId}) async {
    final response =
        await BaseAPI.get2(ApiUrl.getComment, {"post_id": postId});
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return CommentsResponse.fromJson(apiResponseModel.toJson());
  }
}
