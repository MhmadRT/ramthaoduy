import 'package:ramtha/screens/homescreen/model/get_banner_response.dart';

import '../../network/api_response_model.dart';
import '../../network/api_urls.dart';
import '../../network/base_api.dart';
import 'model/get_notifcations_response.dart';

class NotificationsRepository {
  Future<GetNotificationsResponse> getNotifications(Map<String, dynamic> body) async {
    final response = await BaseAPI.get2(ApiUrl.getNotifications, body);
    ApiResponseModel apiResponseModel =
        ApiResponseModel.fromJson(response.toJson());
    return GetNotificationsResponse.fromJson(apiResponseModel.toJson());
  }
  Future<ApiResponseModel> readNotification(Map<String, dynamic> body) async {
    final response = await BaseAPI.post2(ApiUrl.readNotification, body);
    return ApiResponseModel.fromJson(response.toJson());
  }
}
