// To parse this JSON data, do
//
//     final createRequest = createRequestFromJson(jsonString);

import 'dart:convert';


class ForgetPasswordResponse {
  String? name;
  String? username;
  String? password;
  String? cityId;
  String? brigadeId;
  String? districtId;
  String? deviceToken;
  String? platform;
  String? gender;

  ForgetPasswordResponse({
    this.name,
    this.username,
    this.password,
    this.cityId,
    this.brigadeId,
    this.districtId,
    this.deviceToken,
    this.platform,
    this.gender,
  });

  factory ForgetPasswordResponse.fromJson(Map<String, dynamic> json) => ForgetPasswordResponse(
    name: json["name"],
    username: json["username"],
    password: json["password"],
    cityId: json["city_id"],
    brigadeId: json["brigade_id"],
    districtId: json["district_id"],
    deviceToken: json["device_token"],
    platform: json["platform"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "username": username,
    "password": password,
    "city_id": cityId,
    "brigade_id": brigadeId,
    "district_id": districtId,
    "device_token": deviceToken,
    "platform": platform,
    "gender": gender,
  };
}
