import 'package:ramtha/network/api_response_model.dart';
import 'package:ramtha/network/api_urls.dart';
import 'package:ramtha/network/base_api.dart';
import '../createaccountscreen/models/districts.dart';
import 'model/sub_category_model.dart';

class SubCategoryRepository {
  Future<Districts> getDistricts({required String brigadeId}) async {
    final response =
        await BaseAPI.get2(ApiUrl.getDistricts, {"brigade_id": '1'});
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return Districts.fromJson(apiResponseModel.toJson());
  }
  Future<ApiResponseModel> clickAction(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.clickAction, body);
    return ApiResponseModel.fromJson(response.toJson());
  }
  Future<GetServiceClassificationModelResponse> getServiceClassification(Map<String, dynamic> body) async {
    final response = await BaseAPI.get2(ApiUrl.getServiceClassification, body);
    ApiResponseModel apiResponseModel =
    ApiResponseModel.fromJson(response.toJson());
    return GetServiceClassificationModelResponse.fromJson(apiResponseModel.toJson());
  }

}
