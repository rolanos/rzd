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
  final List<FormChoose> choose;

  FormDataClass({
    required this.status,
    required this.formKey,
    required this.formData,
    required this.statusName,
    required this.allowFiles,
    required this.description,
    required this.formDescription,
    this.choose = const [],
  });

  factory FormDataClass.fromJson(Map<String, dynamic> json) {
    List<List<String>> chooses = [];
    for (var i = 0;
        i < (json["formConfiguration"] as Map<String, dynamic>).length;
        i++) {
      final l = (((json["formConfiguration"] as Map<String, dynamic>)
          .values
          .toList()[i]) as List<dynamic>);
      for (var k in l) {
        k = k as Map<String, dynamic>;
        List<String> buf = k.values.map((e) => e.toString()).toList();
        chooses.add(buf);
      }
    }
    final choose = List<FormChoose>.generate(
      (json["formConfiguration"] as Map<String, dynamic>).length,
      (index) => FormChoose.fromMap(
        chooses[index],
        (json["formConfiguration"] as Map<String, dynamic>).keys.toList()[index]
            as String,
      ),
    );

    return FormDataClass(
      status: json["status"] as int?,
      formKey: json["formKey"] as String?,
      formData: json["formData"] as Map<String, dynamic>?,
      statusName: json["statusName"] as String?,
      allowFiles: json["allowFiles"] as bool?,
      description: json["description"] as String?,
      formDescription: List.generate(
        (json["formDescription"] as List).length,
        (index) => FormDescription.fromMap(
          (json["formDescription"][index] as Map<String, dynamic>).values.first,
          (json["formDescription"][index] as Map<String, dynamic>).keys.first,
        ),
      ),
      choose: choose,
    );
  }

  String toJson() {
    Map<String, dynamic> map = {};
    for (var desc in formDescription) {
      map[desc.titleName] = desc.controller.text;
    }
    return json.encode(map);
  }
}

class FormChoose {
  final String titleName;
  final List<String>? choose;

  FormChoose({required this.titleName, required this.choose});

  factory FormChoose.fromMap(List<String> data, String titleName) {
    return FormChoose(
      titleName: titleName,
      choose: data,
    );
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

  static Map<String, dynamic> toMapFromList(List<FormDescription> list) {
    Map<String, dynamic> map = {};
    for (var i in list) {
      map[i.titleName] = i.controller.text.trim();
    }
    return map;
  }
}
