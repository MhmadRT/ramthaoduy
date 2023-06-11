import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:alice/core/alice_http_extensions.dart';
import 'package:http/http.dart' as http;
import 'app_exception.dart';
import 'package:alice/alice.dart';

class BaseAPI {
  static final Map<String, String> _headers = {
    'app-key': '9E075AC2-42A4-4077-BF25-9754E4C32FDC',
    "token": ""
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
    if (isJson == false) return response;
    return _handelResponse(response);
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
