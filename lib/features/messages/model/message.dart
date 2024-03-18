class Message {
  final String? id;
  final String? body;
  final int? level;
  final bool? isRead;
  final DateTime? readed;
  final String? subject;
  final DateTime? timestamp;

  Message({
    this.id,
    this.body,
    this.level,
    this.isRead,
    this.readed,
    this.subject,
    this.timestamp,
  });

  Message copyWith({
    String? id,
    String? body,
    int? level,
    bool? isRead,
    DateTime? readed,
    String? subject,
    DateTime? timestamp,
  }) =>
      Message(
        id: id ?? this.id,
        body: body ?? this.body,
        level: level ?? this.level,
        isRead: isRead ?? this.isRead,
        readed: readed ?? this.readed,
        subject: subject ?? this.subject,
        timestamp: timestamp ?? this.timestamp,
      );

  factory Message.fromJson(Map<String, dynamic> json) {
    String? bodyStr;
    if (json["body"] != null) {
      bodyStr = json["body"] as String?;
      RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

      bodyStr = bodyStr?.replaceAll(exp, '');
    }
    return Message(
      id: json["id"] as String?,
      body: bodyStr,
      level: json["level"] as int?,
      isRead: json["isRead"] as bool?,
      readed: json["readed"] == null
          ? null
          : DateTime.tryParse(json["readed"] as String),
      subject: json["subject"],
      timestamp: json["timestamp"] == null
          ? null
          : DateTime.tryParse(json["timestamp"] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "level": level,
        "isRead": isRead,
        "readed": readed?.toIso8601String(),
        "subject": subject,
        "timestamp": timestamp?.toIso8601String(),
      };
}
