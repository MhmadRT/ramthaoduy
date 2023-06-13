// To parse this JSON data, do
//
//     final brigades = brigadesFromJson(jsonString);

import 'dart:convert';

import 'package:ramtha/helper/custom/custom_drop_down.dart';


class Districts {
  final List<Item>? districts;

  Districts({
    this.districts,
  });

  factory Districts.fromJson(Map<String, dynamic> json) => Districts(
    districts: json["data"]["districts"] == null ? [] : List<Item>.from(json["data"]["districts"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "districts": districts == null ? [] : List<dynamic>.from(districts!.map((x) => x.toJson())),
  };
}

