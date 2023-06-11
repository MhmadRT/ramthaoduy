import 'package:ramtha/network/api_urls.dart';
import 'package:ramtha/network/base_api.dart';

import '../../network/app_exception.dart';
import 'model/login_response.dart';

class LoginRepository {
  Future<dynamic> makeLoginAPI(Map<String, dynamic> body) async {
    try {
      final response = await BaseAPI.post(ApiUrl.login, body);
      LoginResponse loginResponse = LoginResponse.fromJson(response);
      if (loginResponse.status == '0') {
        return AppException(loginResponse.message);
      }
      return loginResponse;
    } catch (ex) {
      return Future.delayed(const Duration(seconds: 1))
          .then((value) => ErrorParsingException("An Error Occurred"));
    }
  }
}
