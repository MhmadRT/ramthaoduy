// To parse this JSON data, do
//
//     final postsResponse = postsResponseFromJson(jsonString);

import 'dart:convert';

PostsResponse postsResponseFromJson(String str) => PostsResponse.fromJson(json.decode(str));

String postsResponseToJson(PostsResponse data) => json.encode(data.toJson());

class PostsResponse {
  final PostsModel? posts;
  final String? status;
  final String? message;

  PostsResponse({
    this.posts,
    this.status,
    this.message,
  });

  factory PostsResponse.fromJson(Map<String, dynamic> json) => PostsResponse(
    posts: json["data"] == null ? null : PostsModel.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": posts?.toJson(),
    "status": status,
    "message": message,
  };
}

class PostsModel {
  final List<Post>? posts;

  PostsModel({
    this.posts,
  });

  factory PostsModel.fromJson(Map<String, dynamic> json) => PostsModel(
    posts: json["posts"] == null ? [] : List<Post>.from(json["posts"]!.map((x) => Post.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "posts": posts == null ? [] : List<dynamic>.from(posts!.map((x) => x.toJson())),
  };
}

class Post {
  final int? id;
  final String? deadName;
  final DateTime? createdDate;
  final int? ageInYears;
  final String? city;
  final int? numberOfComments;
  final String? image;
  final String? gender;
  final String? buryDescription;
  final String? latatude;
  final String? longitude;
  final String? description;
  final String? phoneNumber;
  final String? nameOfRequester;

  Post({
    this.id,
    this.deadName,
    this.createdDate,
    this.ageInYears,
    this.city,
    this.numberOfComments,
    this.image,
    this.gender,
    this.buryDescription,
    this.latatude,
    this.longitude,
    this.description,
    this.phoneNumber,
    this.nameOfRequester,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
    id: json["id"],
    deadName: json["dead_name"],
    createdDate: json["created_date"] == null ? null : DateTime.parse(json["created_date"]),
    ageInYears: json["age_in_years"],
    city: json["city"],
    numberOfComments: json["number_of_comments"],
    image: json["image"],
    gender: json["gender"],
    buryDescription: json["bury_description"],
    latatude: json["latatude"],
    longitude: json["longitude"],
    description: json["description"],
    phoneNumber: json["phone_number"],
    nameOfRequester: json["name_of_requester"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "dead_name": deadName,
    "created_date": "${createdDate!.year.toString().padLeft(4, '0')}-${createdDate!.month.toString().padLeft(2, '0')}-${createdDate!.day.toString().padLeft(2, '0')}",
    "age_in_years": ageInYears,
    "city": city,
    "number_of_comments": numberOfComments,
    "image": image,
    "gender": gender,
    "bury_description": buryDescription,
    "latatude": latatude,
    "longitude": longitude,
    "description": description,
    "phone_number": phoneNumber,
    "name_of_requester": nameOfRequester,
  };
}
