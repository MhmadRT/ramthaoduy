// To parse this JSON data, do
//
//     final brigades = brigadesFromJson(jsonString);

import 'dart:convert';

import 'package:ramtha/helper/custom/custom_drop_down.dart';

class Relationship {
  final List<Item>? relationship;

  Relationship({
    this.relationship,
  });

  factory Relationship.fromJson(Map<String, dynamic> json) => Relationship(
        relationship: json["data"]["relationship"] == null
            ? []
            : List<Item>.from(
                json["data"]["relationship"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "relationship": relationship == null
            ? []
            : List<dynamic>.from(relationship!.map((x) => x.toJson())),
      };
}
