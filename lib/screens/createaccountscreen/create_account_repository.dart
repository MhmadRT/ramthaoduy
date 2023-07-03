import 'package:image_picker/image_picker.dart';
import 'package:ramtha/network/api_response_model.dart';
import 'package:ramtha/network/api_urls.dart';
import 'package:ramtha/network/base_api.dart';
import 'package:ramtha/screens/createaccountscreen/models/brigades.dart';
import 'package:ramtha/screens/createaccountscreen/models/cities.dart';
import 'package:ramtha/screens/createaccountscreen/models/create_response.dart';

import 'models/districts.dart';

class CreateAccountRepository {
  Future<CreateResponse> createAccountAPI(Map<String, dynamic> body) async {
    print(body.toString());
    final response = await BaseAPI.post2(ApiUrl.register, body);
    return CreateResponse.fromJson(response.toJson());
  }
  Future<ApiResponseModel> updateUserInfo(
      {Map<String, String> ?body, XFile? file}) async {
    final response = await BaseAPI.postMultipartRequest(ApiUrl.editUser, body??{},file);
    return ApiResponseModel.fromJson(response.toJson());
  }
  Future<Cities> getCities() async {
    final response = await BaseAPI.get2(ApiUrl.getCities,{});
    ApiResponseModel apiResponseModel =
    ApiResponseModel.fromJson(response.toJson());
    return Cities.fromJson(apiResponseModel.toJson());
  }

  Future<Brigades> getBrigades({required String cityId}) async {
    final response = await BaseAPI.get2(ApiUrl.getBrigades, {"city_id": cityId});
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return Brigades.fromJson(apiResponseModel.toJson());
  }

  Future<Districts> getDistricts({required String brigadeId}) async {
    final response = await BaseAPI.get2(ApiUrl.getDistricts, {"brigade_id": brigadeId});
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return Districts.fromJson(apiResponseModel.toJson());
  }
}
