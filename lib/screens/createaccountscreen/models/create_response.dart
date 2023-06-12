// To parse this JSON data, do
//
//     final createResponse = createResponseFromJson(jsonString);

import 'dart:convert';

CreateResponse createResponseFromJson(String str) => CreateResponse.fromJson(json.decode(str));

String createResponseToJson(CreateResponse data) => json.encode(data.toJson());

class CreateResponse {
  Data? data;
  String? status;
  String? message;

  CreateResponse({
    this.data,
    this.status,
    this.message,
  });

  factory CreateResponse.fromJson(Map<String, dynamic> json) => CreateResponse(
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    status: json["status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "data": data?.toJson(),
    "status": status,
    "message": message,
  };
}

class Data {
  User? user;
  String? token;

  Data({
    this.user,
    this.token,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    token: json["token"],
  );

  Map<String, dynamic> toJson() => {
    "user": user?.toJson(),
    "token": token,
  };
}

class User {
  int? id;
  String? name;
  String? username;
  bool? isBlocked;
  List<UserRole>? userRole;

  User({
    this.id,
    this.name,
    this.username,
    this.isBlocked,
    this.userRole,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    username: json["username"],
    isBlocked: json["is_blocked"],
    userRole: json["user_role"] == null ? [] : List<UserRole>.from(json["user_role"]!.map((x) => UserRole.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "username": username,
    "is_blocked": isBlocked,
    "user_role": userRole == null ? [] : List<dynamic>.from(userRole!.map((x) => x.toJson())),
  };
}

class UserRole {
  int? roleId;
  String? roleName;

  UserRole({
    this.roleId,
    this.roleName,
  });

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
    roleId: json["role_id"],
    roleName: json["role_name"],
  );

  Map<String, dynamic> toJson() => {
    "role_id": roleId,
    "role_name": roleName,
  };
}
