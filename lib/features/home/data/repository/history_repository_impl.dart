import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/features/core/endpoints.dart';
import 'package:rzd/features/home/data/model/history_api.dart';
import 'package:rzd/features/home/domain/entity/history.dart';
import 'package:rzd/features/home/domain/repository/history_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HistoryRepositoryImpl extends HistoryRepository {
  @override
  Future<List<UserHistory>> getAll() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? uuid = preferences.getString('uuid');
    String? cookie = preferences.getString('cookie');
    if (uuid != null && cookie != null) {
      Dio dio = Dio(
        BaseOptions(
          headers: {
            'Cookie': cookie,
          },
        ),
      );
      try {
        final response = await dio.get(
          historyUrl,
          queryParameters: {
            'uuid': uuid,
          },
        );
        if (response.data["requests"] is List<dynamic>) {
          final privileges = response.data["requests"] as List<dynamic>;
          return List.generate(privileges.length,
              (index) => HistoryApi.fromMap(privileges[index]));
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return [];
  }
}
