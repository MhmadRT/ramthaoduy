class GetUserInfoResponse {
  Data? data;
  String? status;
  String? message;

  GetUserInfoResponse({this.data, this.status, this.message});

  GetUserInfoResponse.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['status'] = this.status;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  User? user;

  Data({this.user});

  Data.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? address;
  String? image;
  String? gender;
  bool? isBlocked;
  List<UserRole>? userRole;

  User(
      {this.id,
        this.name,
        this.username,
        this.address,
        this.image,
        this.gender,
        this.isBlocked,
        this.userRole});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    address = json['address'];
    image = json['image'];
    gender = json['gender'];
    isBlocked = json['is_blocked'];
    if (json['user_role'] != null) {
      userRole = <UserRole>[];
      json['user_role'].forEach((v) {
        userRole!.add(new UserRole.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['address'] = this.address;
    data['image'] = this.image;
    data['gender'] = this.gender;
    data['is_blocked'] = this.isBlocked;
    if (this.userRole != null) {
      data['user_role'] = this.userRole!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserRole {
  int? roleId;
  String? roleName;

  UserRole({this.roleId, this.roleName});

  UserRole.fromJson(Map<String, dynamic> json) {
    roleId = json['role_id'];
    roleName = json['role_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['role_id'] = this.roleId;
    data['role_name'] = this.roleName;
    return data;
  }
}
