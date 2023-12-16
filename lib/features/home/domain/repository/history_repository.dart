import 'package:rzd/features/home/domain/entity/history.dart';

abstract class HistoryRepository {
  Future<List<UserHistory>> getAll();
}
