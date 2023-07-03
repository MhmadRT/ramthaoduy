// To parse this JSON data, do
//
//     final postsRequest = postsRequestFromJson(jsonString);

import 'dart:convert';

UpdateRequest postsRequestFromJson(String str) =>
    UpdateRequest.fromJson(json.decode(str));

String updateRequestToJson(UpdateRequest data) => json.encode(data.toJson());

class UpdateRequest {
  final String? name;
  final String? cityId;
  final String? brigadeId;
  final String? districtId;
  final String? image;
  final String? email;
  final String? newPassword;
  final String? oldPassword;

  UpdateRequest(
      {this.name,
      this.cityId,
      this.brigadeId,
      this.newPassword,
      this.oldPassword,
      this.districtId,
      this.image,
      this.email});

  factory UpdateRequest.fromJson(Map<String, dynamic> json) => UpdateRequest(
        name: json["name"],
        brigadeId: json["brigade_id"],
        newPassword: json["new_password"],
        oldPassword: json["old_password"],
        cityId: json["city_id"],
        districtId: json["district_id"],
        image: json["image"],
      );

  Map<String, String> toJson() {
    Map<String, String> data = {
      "name": name ?? "",
      "old_password": oldPassword ?? "",
      "new_password": newPassword ?? "",
      "brigade_id": brigadeId ?? "",
      "city_id": cityId ?? "",
      "district_id": districtId ?? "",
      "image": image ?? "",
      "email": email ?? "",
    };
    data.removeWhere((key, value) => value == "");
    return data;
  }
}
