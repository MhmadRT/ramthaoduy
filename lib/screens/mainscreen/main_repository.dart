import 'package:ramtha/network/api_response_model.dart';

import '../../network/api_urls.dart';
import '../../network/base_api.dart';

class MainRepository {
  Future<ApiResponseModel> makeLogOutAPI(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.logOut, body);
    return ApiResponseModel.fromJson(response.toJson());
  }
}
