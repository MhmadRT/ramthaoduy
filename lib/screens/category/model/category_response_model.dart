class CategoryResponseModel {
  Data? data;
  String? status;
  String? message;

  CategoryResponseModel({this.data, this.status, this.message});

  CategoryResponseModel.fromJson(Map<String, dynamic> json) {
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
  List<Category>? category;

  Data({this.category});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['category'] != null) {
      category = <Category>[];
      json['category'].forEach((v) {
        category!.add(new Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.category != null) {
      data['category'] = this.category!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Category {
  String? title;
  List<Subcategory>? subcategory;

  Category({this.title, this.subcategory});

  Category.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['subcategory'] != null) {
      subcategory = <Subcategory>[];
      json['subcategory'].forEach((v) {
        subcategory!.add(new Subcategory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    if (this.subcategory != null) {
      data['subcategory'] = this.subcategory!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subcategory {
  int? id;
  String? subcategoryTilte;
  String? image;

  Subcategory({this.id, this.subcategoryTilte, this.image});

  Subcategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subcategoryTilte = json['subcategoryTilte'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['subcategoryTilte'] = this.subcategoryTilte;
    data['image'] = this.image;
    return data;
  }
}
