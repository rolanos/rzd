class UsedPrivilege {
  final String? code;
  final DateTime? date;
  final int? type;
  final String? period;
  final String? description;
  final String? privelegesType;

  UsedPrivilege({
    this.code,
    this.date,
    this.type,
    this.period,
    this.description,
    this.privelegesType,
  });

  UsedPrivilege copyWith({
    String? code,
    DateTime? date,
    int? type,
    String? period,
    String? description,
    String? privelegesType,
  }) =>
      UsedPrivilege(
        code: code ?? this.code,
        date: date ?? this.date,
        type: type ?? this.type,
        period: period ?? this.period,
        description: description ?? this.description,
        privelegesType: privelegesType ?? this.privelegesType,
      );

  factory UsedPrivilege.fromJson(Map<String, dynamic> json) => UsedPrivilege(
        code: json["code"] as String?,
        date: json["date"] == null
            ? null
            : DateTime.tryParse(json["date"] as String),
        type: json["type"] as int?,
        period: json["period"] as String?,
        description: json["description"] as String?,
        privelegesType: json["priveleges_type"] as String?,
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "type": type,
        "period": period,
        "description": description,
        "priveleges_type": privelegesType,
      };
}
