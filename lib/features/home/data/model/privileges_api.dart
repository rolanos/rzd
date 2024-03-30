import 'package:rzd/features/home/domain/entity/privileges.dart';

class PrivilegesApi {
  static Privileges fromMap(Map<String, dynamic> map) {
    return Privileges(
      id: map['id'] as String,
      description: map['description'] as String,
    );
  }
}
