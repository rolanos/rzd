import 'package:rzd/features/home/domain/entity/privileges.dart';

class PrivilegesApi {
  static Map<String, dynamic> toMap(Privileges priveleges) {
    return <String, dynamic>{
      'id': priveleges.id,
      'description': priveleges.description,
    };
  }

  static Privileges fromMap(Map<String, dynamic> map) {
    return Privileges(
      id: map['id'] as String,
      description: map['description'] as String,
    );
  }
}
