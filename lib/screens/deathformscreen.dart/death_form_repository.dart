import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:ramtha/network/api_response_model.dart';
import 'package:ramtha/network/api_urls.dart';
import 'package:ramtha/network/base_api.dart';


class DeathFormRepository {
  Future<ApiResponseModel> addDeaths(
      Map<String, String> body, XFile? file, XFile? file2,) async {
    final response =
        await BaseAPI.postMultipartRequest(ApiUrl.addDeath, body, file,fileCard:file2 );
    return ApiResponseModel.fromJson(response.toJson());
  }
}
