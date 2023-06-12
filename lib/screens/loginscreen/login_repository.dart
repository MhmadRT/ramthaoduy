import 'package:ramtha/network/api_urls.dart';
import 'package:ramtha/network/base_api.dart';

import '../../network/app_exception.dart';
import 'model/login_response.dart';

class LoginRepository {

  Future<LoginResponse> makeLoginAPI(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.login, body);
    return LoginResponse.fromJson(response.toJson());
  }

}
