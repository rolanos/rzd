import 'package:rzd/core/extensions.dart';

class FaqInfo {
  final String? question;
  final String? answer;
  final DateTime? questionDate;

  FaqInfo({
    required this.question,
    required this.answer,
    required this.questionDate,
  });

  factory FaqInfo.fromJson(Map<String, dynamic> json) => FaqInfo(
        question: (json["question"] as String?)?.parseHtmlString(),
        answer: (json["answer"] as String?)?.parseHtmlString(),
        questionDate: DateTime.parse(json["question_date"]),
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
        "question_date": questionDate?.toIso8601String(),
      };
}
