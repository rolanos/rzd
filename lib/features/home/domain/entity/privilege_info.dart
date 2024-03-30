// To parse this JSON data, do
//
//     final privilegeInfo = privilegeInfoFromJson(jsonString);

import 'dart:convert';

import 'package:rzd/core/extensions.dart';

PrivilegeInfo privilegeInfoFromJson(String str) =>
    PrivilegeInfo.fromJson(json.decode(str));

String privilegeInfoToJson(PrivilegeInfo data) => json.encode(data.toJson());

class PrivilegeInfo {
  final String? title;
  final List<Chapter> chapters;

  PrivilegeInfo({
    required this.title,
    required this.chapters,
  });

  factory PrivilegeInfo.fromJson(Map<String, dynamic> json) => PrivilegeInfo(
        title: (json["title"] as String?)?.parseHtmlString(),
        chapters: List<Chapter>.from(
            json["chapters"].map((x) => Chapter.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "chapters": List<dynamic>.from(chapters.map((x) => x.toJson())),
      };
}

class Chapter {
  final String? title;
  final String? description;
  final List<Item>? items;

  Chapter({
    required this.title,
    this.description,
    this.items,
  });

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        title: (json["title"] as String?)?.parseHtmlString(),
        description: (json["description"] as String?)?.parseHtmlString(),
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "items": items == null
            ? []
            : List<dynamic>.from(items!.map((x) => x.toJson())),
      };
}

class Item {
  final String? title;
  final String? description;

  Item({
    required this.title,
    required this.description,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        title: (json["title"] as String?)?.parseHtmlString(),
        description: (json["description"] as String?)?.parseHtmlString(),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
