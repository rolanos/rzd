class Appeal {
  final int? id;
  final String? type;
  final String? state;
  final DateTime? moment;
  final String? comment;
  final String? subject;
  final String? application;

  Appeal({
    this.id,
    this.type,
    this.state,
    this.moment,
    this.comment,
    this.subject,
    this.application,
  });

  Appeal copyWith({
    int? id,
    String? type,
    String? state,
    DateTime? moment,
    String? comment,
    String? subject,
    String? application,
  }) =>
      Appeal(
        id: id ?? this.id,
        type: type ?? this.type,
        state: state ?? this.state,
        moment: moment ?? this.moment,
        comment: comment ?? this.comment,
        subject: subject ?? this.subject,
        application: application ?? this.application,
      );

  factory Appeal.fromJson(Map<String, dynamic> json) => Appeal(
        id: json["id"] as int?,
        type: json["type"] as String?,
        state: json["state"] as String?,
        moment: json["moment"] == null
            ? null
            : DateTime.tryParse(json["moment"] as String),
        comment: json["comment"] as String?,
        subject: json["subject"] as String?,
        application: json["application"] as String?,
      );
}
