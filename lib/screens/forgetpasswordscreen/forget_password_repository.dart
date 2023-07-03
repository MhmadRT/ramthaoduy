import 'package:ramtha/network/api_response_model.dart';
import 'package:ramtha/network/api_urls.dart';
import 'package:ramtha/network/base_api.dart';



class ForgetPasswordRepository {
  Future<ApiResponseModel> forgetPasswordAPI(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.forgetPassword, body);
    return ApiResponseModel.fromJson(response.toJson());
  }

}
