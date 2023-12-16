import 'package:rzd/features/home/domain/entity/history.dart';

class HistoryApi {
  static Map<String, dynamic> toMap(UserHistory history) {
    return <String, dynamic>{
      'id': history.id,
      'type': history.type,
      'state': history.state,
      'moment': history.moment.toIso8601String(),
      'comment': history.comment,
      'subject': history.subject,
      'application': history.application,
    };
  }

  static UserHistory fromMap(Map<String, dynamic> map) {
    return UserHistory(
      id: map['id'] as int,
      type: map['type'] as String,
      state: map['state'] as String,
      moment: DateTime.parse(map['moment'] as String),
      comment: map['comment'] as String,
      subject: map['subject'] as String,
      application: map['application'] as String,
    );
  }
}
