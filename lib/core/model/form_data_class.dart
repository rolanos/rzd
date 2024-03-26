import 'dart:convert';

import 'package:flutter/material.dart';

class FormDataClass {
  final int? status;
  final String? formKey;
  final Map<String, dynamic>? formData;
  final String? statusName;
  final bool? allowFiles;
  final String? description;
  final List<FormDescription> formDescription;

  FormDataClass({
    required this.status,
    required this.formKey,
    required this.formData,
    required this.statusName,
    required this.allowFiles,
    required this.description,
    required this.formDescription,
  });

  factory FormDataClass.fromJson(Map<String, dynamic> json) => FormDataClass(
        status: json["status"] as int?,
        formKey: json["formKey"] as String?,
        formData: json["formData"] as Map<String, dynamic>?,
        statusName: json["statusName"] as String?,
        allowFiles: json["allowFiles"] as bool?,
        description: json["description"] as String?,
        formDescription: List.generate(
          (json["formDescription"] as List).length,
          (index) => FormDescription.fromMap(
            (json["formDescription"][index] as Map<String, dynamic>)
                .values
                .first,
            (json["formDescription"][index] as Map<String, dynamic>).keys.first,
          ),
        ),
      );

  String toJson() {
    Map<String, dynamic> map = {};
    for (var desc in formDescription) {
      map[desc.titleName] = desc.controller.text;
    }
    return json.encode(map);
  }
}

class FormDescription {
  final String titleName;
  final String? type;
  final String? title;
  final bool? required;

  TextEditingController controller = TextEditingController();

  FormDescription(
      {required this.titleName,
      required this.type,
      required this.title,
      required this.required});

  factory FormDescription.fromMap(Map<String, dynamic> data, String titleName) {
    return FormDescription(
        titleName: titleName,
        type: data['type'] as String?,
        title: data['title'] as String?,
        required: data['required'] as bool?);
  }
}
