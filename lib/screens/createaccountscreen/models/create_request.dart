// To parse this JSON data, do
//
//     final createRequest = createRequestFromJson(jsonString);

import 'dart:convert';

CreateRequest createRequestFromJson(String str) => CreateRequest.fromJson(json.decode(str));

String createRequestToJson(CreateRequest data) => json.encode(data.toJson());

class CreateRequest {
  String? name;
  String? username;
  String? password;
  String? email;
  String? cityId;
  String? brigadeId;
  String? districtId;
  String? deviceToken;
  String? platform;
  String? gender;
  String? idNumber;

  CreateRequest({
    this.name,
    this.email,
    this.username,
    this.password,
    this.cityId,
    this.brigadeId,
    this.idNumber,
    this.districtId,
    this.deviceToken,
    this.platform,
    this.gender,
  });

  factory CreateRequest.fromJson(Map<String, dynamic> json) => CreateRequest(
    name: json["name"],
    idNumber: json["idNumber"],
    email: json["email"],
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
    "email": email,
    "idNumber": idNumber,
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
