class AppDocument {
  final int? documentId;
  final String? title;
  final String? description;
  final String? linkName;
  final DateTime? documentDate;

  AppDocument({
    this.documentId,
    this.title,
    this.description,
    this.linkName,
    this.documentDate,
  });

  factory AppDocument.fromJson(Map<String, dynamic> json) => AppDocument(
        documentId: json["document_id"],
        title: json["title"],
        description: json["description"],
        linkName: json["link_name"],
        documentDate: json["document_date"] == null
            ? null
            : DateTime.parse(json["document_date"]),
      );

  Map<String, dynamic> toJson() => {
        "document_id": documentId,
        "title": title,
        "description": description,
        "link_name": linkName,
        "document_date": documentDate?.toIso8601String(),
      };
}
