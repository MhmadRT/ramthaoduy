import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:alice/core/alice_http_extensions.dart';
import 'package:http/http.dart' as http;
import 'package:ramtha/network/api_response_model.dart';
import '../helper/local_storage_helper.dart';
import '../screens/mainscreen/main_controller.dart';
import 'app_exception.dart';
import 'package:alice/alice.dart';

class BaseAPI {
  static final Map<String, String> _headers = {
    'Accept': 'application/json',
    'api_key':
        'ZZnUS84FEKcw8roZlLwrJ83keSGj661AMomSjTMpiEsBoIlSgsOPI9kHV1ByV7ekBmOqe3oZ63ar8tV55vNZH4J78SMLCAR9iNxrHEXx6pMLVkU1KjzDUEGd9kaVAmZlB3dD4HZSXT4WdGFTDfmzJKlPuBQU4ep4MYQMewlqd8EclYwyZb4DKA7e7dyLyHgkkGOYGN6rQV9zhXPx2gS0LUJpagcDN827VHJ9Uivy5mCbTTpomydCh0Xpjz4UIrFh'
  };

  static Alice alice = Alice(
    showNotification: true,
    showInspectorOnShake: true,
    darkTheme: true,
    maxCallsCount: 10,
  );
  static const int _timeOutValueSeconds = 1000;

  static Future<dynamic> get(String url, Map<String, dynamic> body,
      {bool? isJson}) async {
    http.Response response;
    try {
      final String queryString = Uri(
          queryParameters:
              body.map((key, value) => MapEntry(key, value?.toString()))).query;

      String fullUrl = "$url?$queryString";
      log('START', name: 'Get $fullUrl API');
      response = await http
          .get(Uri.parse(fullUrl), headers: _headers)
          .interceptWithAlice(alice, body: body)
          .timeout(
            const Duration(seconds: _timeOutValueSeconds),
          );
      log(response.body, name: 'STATUS CODE ${response.statusCode}');
    } on SocketException catch (e) {
      log(e.message);
      throw FetchDataException('No Internet connection');
    } on Exception {
      throw FetchDataException('Server Error');
    }
    if (isJson == false) return response.bodyBytes;
    return _handelResponse(response);
  }

  static Future<ApiResponseModel> post2(
      String url, Map<String, dynamic> body) async {
    try {
      var response = await http
          .post(Uri.parse(url), headers: await getHeader(), body: body)
          .interceptWithAlice(alice, body: body)
          .timeout(
            const Duration(seconds: _timeOutValueSeconds),
          );
      log('START', name: 'post $url API $body',);
      Future.delayed(Duration(seconds: 1))
          .then((value) => print(response.body));

      return ApiResponseModel.fromJson(json.decode(response.body));
    } catch (e) {
      return ApiResponseModel(message: 'حدث خطاء', status: '0', data: {});
    }
  }

  static Future<ApiResponseModel> get2(
      String url, Map<String, dynamic> body) async {
    try {
      final String queryString = Uri(
          queryParameters:
              body.map((key, value) => MapEntry(key, value?.toString()))).query;
      String fullUrl = "$url?$queryString";
      log('START', name: 'Get $fullUrl API');
      var response = await http
          .get(Uri.parse(fullUrl), headers: await getHeader())
          .interceptWithAlice(alice, body: body)
          .timeout(
            const Duration(seconds: _timeOutValueSeconds),
          );
      log(response.body, name: 'STATUS CODE ${response.statusCode}');
      if (response.statusCode == 401) {
        makeLogOut();
      }

      return ApiResponseModel.fromJson(json.decode(response.body));
    } catch (e) {
      log(e.toString(), error: 'GET API ERROR $url');
      return ApiResponseModel(message: 'حدث خطاء', status: '0', data: {});
    }
  }

  static Future<Map<String, String>> getHeader() async {
    String apiKey =
        'ZZnUS84FEKcw8roZlLwrJ83keSGj661AMomSjTMpiEsBoIlSgsOPI9kHV1ByV7ekBmOqe3oZ63ar8tV55vNZH4J78SMLCAR9iNxrHEXx6pMLVkU1KjzDUEGd9kaVAmZlB3dD4HZSXT4WdGFTDfmzJKlPuBQU4ep4MYQMewlqd8EclYwyZb4DKA7e7dyLyHgkkGOYGN6rQV9zhXPx2gS0LUJpagcDN827VHJ9Uivy5mCbTTpomydCh0Xpjz4UIrFh';
    String? token = await LocalStorageHelper.getToken();
    Map<String, String> header = {
      'api_key': apiKey,
      'Accept': 'application/json',
      'Authorization': 'Bearer $token'
    };
    return header;
  }

  static Future<dynamic> post(String url, Map<String, dynamic> body,
      {bool? isJson}) async {
    http.Response response;
    try {
      log(body.toString(), name: 'POST $url API');
      response = await http
          .post(Uri.parse(url), headers: _headers, body: body)
          .interceptWithAlice(alice, body: body)
          .timeout(
            const Duration(seconds: _timeOutValueSeconds),
          );
      log(response.body, name: 'STATUS CODE ${response.statusCode}');
    } on SocketException catch (e) {
      log(e.message);
      throw FetchDataException('No Internet connection');
    } on Exception {
      throw FetchDataException('Server Error');
    }
    // if (isJson == false) return response;
    return json.encode(response);
  }

  static Future<dynamic> put(String url, Map<String, dynamic> body,
      {bool? isJson}) async {
    http.Response response;
    try {
      final String queryString = Uri(
          queryParameters:
              body.map((key, value) => MapEntry(key, value?.toString()))).query;

      String fullUrl = "$url?$queryString";
      log('START', name: 'PUT $fullUrl API');
      response = await http
          .put(Uri.parse(fullUrl), headers: _headers)
          .interceptWithAlice(alice, body: body)
          .timeout(
            const Duration(seconds: _timeOutValueSeconds),
          );
      log(response.body, name: 'STATUS CODE ${response.statusCode}');
    } on SocketException catch (e) {
      log(e.message);
      throw FetchDataException('No Internet connection');
    } on Exception {
      throw FetchDataException('Server Error');
    }
    if (isJson == false) return response;
    return _handelResponse(response);
  }

  static Future<dynamic> head(String url, Map<String, dynamic> body,
      {bool? isJson}) async {
    http.Response response;
    try {
      final String queryString = Uri(
          queryParameters:
              body.map((key, value) => MapEntry(key, value?.toString()))).query;

      String fullUrl = "$url?$queryString";
      log('START', name: 'HEAD $fullUrl API');
      response = await http
          .head(Uri.parse(fullUrl), headers: _headers)
          .interceptWithAlice(alice, body: body)
          .timeout(
            const Duration(seconds: _timeOutValueSeconds),
          );
      log(response.body, name: 'STATUS CODE ${response.statusCode}');
    } on SocketException catch (e) {
      log(e.message);
      throw FetchDataException('No Internet connection');
    } on Exception {
      throw FetchDataException('Server Error');
    }
    if (isJson == false) return response;
    return _handelResponse(response);
  }

  static http.Response _handelResponse(http.Response response) {
    return response;
  }
}
