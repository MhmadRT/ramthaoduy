import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';

class RateRepository {
  Future<ApiResponseModel> rate(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.rate, body);
    return ApiResponseModel.fromJson(response.toJson());
  }
}
