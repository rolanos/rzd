// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TeethForm {
  final String type_service;
  final int? chuz;
  final String? mobile_phone;
  final String? home_phone;
  final String? email;
  final String? comment;
  TeethForm({
    required this.type_service,
    this.chuz,
    this.mobile_phone,
    this.home_phone,
    this.email,
    this.comment,
  });

  ///Разобраться и дописать array

  TeethForm copyWith({
    String? type_service,
    int? chuz,
    String? mobile_phone,
    String? home_phone,
    String? email,
    String? comment,
  }) {
    return TeethForm(
      type_service: type_service ?? this.type_service,
      chuz: chuz ?? this.chuz,
      mobile_phone: mobile_phone ?? this.mobile_phone,
      home_phone: home_phone ?? this.home_phone,
      email: email ?? this.email,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type_service': type_service,
      'chuz': chuz,
      'mobile_phone': mobile_phone,
      'home_phone': home_phone,
      'email': email,
      'comment': comment,
    };
  }

  factory TeethForm.fromMap(Map<String, dynamic> map) {
    return TeethForm(
      type_service: map['type_service'] as String,
      chuz: map['chuz'] != null ? map['chuz'] as int : null,
      mobile_phone:
          map['mobile_phone'] != null ? map['mobile_phone'] as String : null,
      home_phone:
          map['home_phone'] != null ? map['home_phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TeethForm.fromJson(String source) =>
      TeethForm.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'TeethForm(type_service: $type_service, chuz: $chuz, mobile_phone: $mobile_phone, home_phone: $home_phone, email: $email, comment: $comment)';
  }

  @override
  bool operator ==(covariant TeethForm other) {
    if (identical(this, other)) return true;

    return other.type_service == type_service &&
        other.chuz == chuz &&
        other.mobile_phone == mobile_phone &&
        other.home_phone == home_phone &&
        other.email == email &&
        other.comment == comment;
  }

  @override
  int get hashCode {
    return type_service.hashCode ^
        chuz.hashCode ^
        mobile_phone.hashCode ^
        home_phone.hashCode ^
        email.hashCode ^
        comment.hashCode;
  }
}
