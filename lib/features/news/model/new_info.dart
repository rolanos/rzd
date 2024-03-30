import 'package:rzd/core/extensions.dart';

class NewInfo {
  final int contentId;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? title;
  final String? description;
  final String? text;
  final bool? main;
  final String? image;

  NewInfo({
    required this.contentId,
    this.startDate,
    this.image,
    this.endDate,
    this.title,
    this.description,
    this.text,
    this.main,
  });

  factory NewInfo.fromJson(Map<String, dynamic> json) => NewInfo(
        contentId: (json["content_id"]),
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        title: (json["title"] as String?)?.parseHtmlString(),
        description: (json["description"] as String?)?.parseHtmlString(),
        text: (json["text"] as String?)?.parseHtmlString(),
        main: json["main"],
      );
  NewInfo copyWithImage({String? imageBinary}) {
    print(imageBinary);
    return NewInfo(
        contentId: contentId,
        startDate: startDate,
        endDate: endDate,
        title: title,
        description: description,
        text: text,
        main: main,
        image: imageBinary);
  }
}
