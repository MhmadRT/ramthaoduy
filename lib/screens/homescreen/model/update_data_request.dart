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

  UpdateRequest({
    this.name,
    this.cityId,
    this.brigadeId,
    this.districtId,
    this.image
  });

  factory UpdateRequest.fromJson(Map<String, dynamic> json) => UpdateRequest(
    name: json["name"],
    brigadeId: json["brigade_id"],
    cityId: json["city_id"],
    districtId: json["district_id"],
    image: json["image"],
  );

  Map<String, String> toJson() {
    Map<String, String> data = {
      "name": name??"",
      "brigade_id": brigadeId??"",
      "city_id": cityId??"",
      "district_id": districtId??"",
      "image": image??"",
    };
    data.removeWhere((key, value) => value == "");
    return data;
  }
}
