
import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import 'model/category_response_model.dart';

class CategoryRepository {


  Future<CategoryResponseModel> getMainCategory(Map<String, dynamic> body) async {
    final response = await BaseAPI.get2(ApiUrl.getMainCategory, body);
    ApiResponseModel apiResponseModel =
    ApiResponseModel.fromJson(response.toJson());
    return CategoryResponseModel.fromJson(apiResponseModel.toJson());
  }

}
