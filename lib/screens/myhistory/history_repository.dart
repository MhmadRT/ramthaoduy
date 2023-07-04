import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import '../homescreen/model/posts_response.dart';

class HistoryRepository {
  Future<PostsResponse> getHistory(Map<String, dynamic> body) async {
    final response = await BaseAPI.get2(ApiUrl.userHistory, body);
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return PostsResponse.fromJson(apiResponseModel.toJson());
  }
}
