// To parse this JSON data, do
//
//     final loginRequest = loginRequestFromJson(jsonString);

import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  String? username;
  String? password;
  String? deviceToken;
  String? platform;

  LoginRequest({
    this.username,
    this.password,
    this.deviceToken,
    this.platform,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    username: json["username"],
    password: json["password"],
    deviceToken: json["device_token"],
    platform: json["platform"],
  );

  Map<String, dynamic> toJson() => {
    "username": username,
    "password": password,
    "device_token": deviceToken,
    "platform": platform,
  };
}
