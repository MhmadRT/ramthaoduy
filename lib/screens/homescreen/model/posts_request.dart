// To parse this JSON data, do
//
//     final postsRequest = postsRequestFromJson(jsonString);

import 'dart:convert';

PostsRequest postsRequestFromJson(String str) =>
    PostsRequest.fromJson(json.decode(str));

String postsRequestToJson(PostsRequest data) => json.encode(data.toJson());

class PostsRequest {
  final String? fromDate;
  final String? toDate;
  final String? gender;
  final String? cityId;
  final String? page;

  PostsRequest({
    this.fromDate,
    this.toDate,
    this.gender,
    this.page,
    this.cityId,
  });

  factory PostsRequest.fromJson(Map<String, dynamic> json) => PostsRequest(
        fromDate: json["from_date"],
        page: json["page"],
        toDate: json["to_date"],
        gender: json["gender"],
        cityId: json["city_id"],
      );

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = {
      "from_date": fromDate,
      "page": page,
      "to_date": toDate,
      "gender": gender,
      "city_id": cityId,
    };
    data.removeWhere((key, value) => value == null);
    return data;
  }
}
