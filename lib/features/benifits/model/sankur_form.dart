// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SankurForm {
  ///required
  final int period;
  final int year;
  final int days;
  final String filename;

  final int? sanprof;
  final String? category;
  final String? alt;
  final bool? no_treatment;
  final String? mobile_phone;
  final String? home_phone;
  final String? email;
  final String? comment;
  SankurForm({
    required this.period,
    required this.year,
    required this.days,
    required this.filename,
    this.sanprof,
    this.category,
    this.alt,
    this.no_treatment,
    this.mobile_phone,
    this.home_phone,
    this.email,
    this.comment,
  });

  SankurForm copyWith({
    int? period,
    int? year,
    int? days,
    String? filename,
    int? sanprof,
    String? category,
    String? alt,
    bool? no_treatment,
    String? mobile_phone,
    String? home_phone,
    String? email,
    String? comment,
  }) {
    return SankurForm(
      period: period ?? this.period,
      year: year ?? this.year,
      days: days ?? this.days,
      filename: filename ?? this.filename,
      sanprof: sanprof ?? this.sanprof,
      category: category ?? this.category,
      alt: alt ?? this.alt,
      no_treatment: no_treatment ?? this.no_treatment,
      mobile_phone: mobile_phone ?? this.mobile_phone,
      home_phone: home_phone ?? this.home_phone,
      email: email ?? this.email,
      comment: comment ?? this.comment,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'period': period,
      'year': year,
      'days': days,
      'filename': filename,
      'sanprof': sanprof,
      'category': category,
      'alt': alt,
      'no_treatment': no_treatment,
      'mobile_phone': mobile_phone,
      'home_phone': home_phone,
      'email': email,
      'comment': comment,
    };
  }

  factory SankurForm.fromMap(Map<String, dynamic> map) {
    return SankurForm(
      period: map['period'] as int,
      year: map['year'] as int,
      days: map['days'] as int,
      filename: map['filename'] as String,
      sanprof: map['sanprof'] != null ? map['sanprof'] as int : null,
      category: map['category'] != null ? map['category'] as String : null,
      alt: map['alt'] != null ? map['alt'] as String : null,
      no_treatment:
          map['no_treatment'] != null ? map['no_treatment'] as bool : null,
      mobile_phone:
          map['mobile_phone'] != null ? map['mobile_phone'] as String : null,
      home_phone:
          map['home_phone'] != null ? map['home_phone'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      comment: map['comment'] != null ? map['comment'] as String : null,
    );
  }
}
