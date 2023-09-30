class GetServiceClassificationModelResponse {
  Data? data;
  String? status;
  String? message;

  GetServiceClassificationModelResponse({this.data, this.status, this.message});

  GetServiceClassificationModelResponse.fromJson(Map<String, dynamic> json) {
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
  List<ServiceClassification>? serviceClassification;

  Data({this.serviceClassification});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['serviceClassification'] != null) {
      serviceClassification = <ServiceClassification>[];
      json['serviceClassification'].forEach((v) {
        serviceClassification!.add(new ServiceClassification.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.serviceClassification != null) {
      data['serviceClassification'] =
          this.serviceClassification!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ServiceClassification {
  int? id;
  String? name;
  String? district;
  String? image;
  String? phone;
  String? address;

  ServiceClassification(
      {this.id,
        this.name,
        this.district,
        this.image,
        this.phone,
        this.address});

  ServiceClassification.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    district = json['district'];
    image = json['image'];
    phone = json['phone'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['district'] = this.district;
    data['image'] = this.image;
    data['phone'] = this.phone;
    data['address'] = this.address;
    return data;
  }
}
