class GetBannerResponse {
  List<BannersData>? data;
  String? status;
  String? message;

  GetBannerResponse({this.data, this.status, this.message});

  GetBannerResponse.fromJson(Map<dynamic, dynamic> json) {
    if (json['data'] != null) {
      data = <BannersData>[];
      json['data'].forEach((v) {
        data!.add(BannersData.fromJson(v));
      });
    }
    status = json['status'];
    message = json['message'];
  }

}

class BannersData {
  int? id;
  String? image;
  String? link;

  BannersData({this.id, this.image, this.link});

  BannersData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['link'] = this.link;
    return data;
  }
}
