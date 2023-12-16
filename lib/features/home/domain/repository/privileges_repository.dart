import 'package:rzd/features/home/domain/entity/privileges.dart';

abstract class PrivilegesRepository {
  ///Получаем все
  Future<List<Privileges>> getPrivileges();
}
