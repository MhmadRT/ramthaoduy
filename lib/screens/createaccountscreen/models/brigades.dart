// To parse this JSON data, do
//
//     final brigades = brigadesFromJson(jsonString);

import 'dart:convert';

import 'package:ramtha/helper/custom/custom_drop_down.dart';


class Brigades {
  final List<Item>? brigades;

  Brigades({
    this.brigades,
  });

  factory Brigades.fromJson(Map<String, dynamic> json) => Brigades(
    brigades: json["data"]["brigades"] == null ? [] : List<Item>.from(json["data"]["brigades"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "brigades": brigades == null ? [] : List<dynamic>.from(brigades!.map((x) => x.toJson())),
  };
}

