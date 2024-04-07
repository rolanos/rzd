// To parse this JSON data, do
//
//     final appInfo = appInfoFromJson(jsonString);

import 'dart:convert';

AppInfo appInfoFromJson(String str) => AppInfo.fromJson(json.decode(str));

String appInfoToJson(AppInfo data) => json.encode(data.toJson());

class AppInfo {
  final Common? common;
  final Personal? personal;
  final About? about;
  final About? useful;

  AppInfo({
    this.common,
    this.personal,
    this.about,
    this.useful,
  });

  factory AppInfo.fromJson(Map<String, dynamic> json) => AppInfo(
        common: json["common"] == null ? null : Common.fromJson(json["common"]),
        personal: json["personal"] == null
            ? null
            : Personal.fromJson(json["personal"]),
        about: json["about"] == null ? null : About.fromJson(json["about"]),
        useful: json["useful"] == null ? null : About.fromJson(json["useful"]),
      );

  Map<String, dynamic> toJson() => {
        "common": common?.toJson(),
        "personal": personal?.toJson(),
        "about": about?.toJson(),
        "useful": useful?.toJson(),
      };
}

class About {
  final String? title;
  final String? description;
  final List<Personal>? links;

  About({
    this.title,
    this.description,
    this.links,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
        title: json["title"],
        description: json["description"],
        links: json["links"] == null
            ? []
            : List<Personal>.from(
                json["links"]!.map((x) => Personal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
      };
}

class Personal {
  final String? title;
  final String? link;

  Personal({
    this.title,
    this.link,
  });

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
        title: json["title"],
        link: json["link"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "link": link,
      };
}

class Common {
  final String? title;
  final String? description;

  Common({
    this.title,
    this.description,
  });

  factory Common.fromJson(Map<String, dynamic> json) => Common(
        title: json["title"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
      };
}
