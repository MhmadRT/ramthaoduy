import 'package:ramtha/screens/homescreen/model/get_banner_response.dart';

import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import 'model/comments_response.dart';
import 'model/get_number_readed_notification.dart';
import 'model/posts_response.dart';

class HomeRepository {
  Future<PostsResponse> getPosts(Map<String, dynamic> body) async {
    final response = await BaseAPI.get2(ApiUrl.getDeaths, body);
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return PostsResponse.fromJson(apiResponseModel.toJson());
  }

  Future<GetNumberNotReaded> getNumberNotifications(Map<String, dynamic> body) async {
    final response = await BaseAPI.get2(ApiUrl.numberNumberReaded, body);
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return GetNumberNotReaded.fromJson(apiResponseModel.toJson());
  }

  Future<ApiResponseModel> addComment(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.addComment, body);
    return ApiResponseModel.fromJson(response.toJson());
  }

  Future<ApiResponseModel> deleteComment(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.deleteComment, body);
    return ApiResponseModel.fromJson(response.toJson());
  }

  Future<GetBannerResponse> getBanner(Map<String, dynamic> body) async {
    final response = await BaseAPI.get2(ApiUrl.getBanners, body);
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return GetBannerResponse.fromJson(apiResponseModel.toJson());
  }

  Future<CommentsResponse> getComment({required String postId}) async {
    final response = await BaseAPI.get2(ApiUrl.getComment, {"post_id": postId});
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return CommentsResponse.fromJson(apiResponseModel.toJson());
  }
}
