import 'package:ramtha/network/api_urls.dart';
import 'package:ramtha/network/base_api.dart';
import 'package:ramtha/screens/createaccountscreen/models/create_response.dart';

import '../../network/app_exception.dart';

class CreateAccountRepository {
  Future<CreateResponse> createAccountAPI(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.register, body);
    return CreateResponse.fromJson(response.toJson());
  }
}
