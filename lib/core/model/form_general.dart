import 'dart:convert';

FormGeneral formGeneralFromJson(String str) =>
    FormGeneral.fromJson(json.decode(str));

String formGeneralToJson(FormGeneral data) => json.encode(data.toJson());

class FormGeneral {
  final String formName;
  final String formKey;
  String? image;

  FormGeneral({
    required this.formName,
    required this.formKey,
  });

  factory FormGeneral.fromJson(Map<String, dynamic> json) => FormGeneral(
        formName: json["formName"],
        formKey: json["formKey"],
      );

  Map<String, dynamic> toJson() => {
        "formName": formName,
        "formKey": formKey,
      };
}
