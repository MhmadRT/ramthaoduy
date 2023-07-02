import 'package:ramtha/network/api_urls.dart';
import 'package:ramtha/network/base_api.dart';

import 'model/forget_password_request.dart';
import 'model/forget_password_response.dart';


class ForgetPasswordRepository {
  Future<ForgetPasswordResponse> forgetPasswordAPI(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.forgetPassword, body);
    return ForgetPasswordResponse.fromJson(response.toJson());
  }

}
