class GetNumberNotReaded {
  DataNumberNot? data;
  String? status;
  String? message;

  GetNumberNotReaded({this.data, this.status, this.message});

  GetNumberNotReaded.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new DataNumberNot.fromJson(json['data']) : null;
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

class DataNumberNot {
  int? count;

  DataNumberNot({this.count});

  DataNumberNot.fromJson(Map<String, dynamic> json) {
    count = json['count']??0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = count;
    return data;
  }
}
