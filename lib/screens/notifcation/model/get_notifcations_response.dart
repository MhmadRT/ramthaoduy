class GetNotificationsResponse {
  List<DataNotifications>? data;
  String? status;
  String? message;

  GetNotificationsResponse({this.data, this.status, this.message});

  GetNotificationsResponse.fromJson(Map<String, dynamic> json) {
    if (json['data']['notifications'] != null) {
      data = <DataNotifications>[];
      json['data']['notifications'].forEach((v) {
        data!.add(DataNotifications.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    data['message'] = message;
    return data;
  }
}

class DataNotifications {
  int? id;
  String? title;
  String? body;
  int? isRead;
  String? createdAt;

  DataNotifications({this.id, this.title, this.body, this.isRead, this.createdAt});

  DataNotifications.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    body = json['body'];
    isRead = json['is_read'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['body'] = body;
    data['is_read'] = isRead;
    data['created_at'] = createdAt;
    return data;
  }
}
