// To parse this JSON data, do
//
//     final brigades = brigadesFromJson(jsonString);

import 'dart:convert';

import 'package:ramtha/helper/custom/custom_drop_down.dart';


class Cities {
  final List<Item>? cities;

  Cities({
    this.cities,
  });

  factory Cities.fromJson(Map<String, dynamic> json) => Cities(
    cities: json["data"]["cities"] == null ? [] : List<Item>.from(json["data"]["cities"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "cities": cities == null ? [] : List<dynamic>.from(cities!.map((x) => x.toJson())),
  };
}

