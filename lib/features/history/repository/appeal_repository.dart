import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/features/history/model/appeal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppealRepository {
  Future<List<Appeal>> getAppeals() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final uuid = preferences.getString('uuid');
    final cookie = preferences.getString('cookie');
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
          getAppealsUrl,
          queryParameters: {
            'uuid': uuid,
          },
        );
        if (response.data["requests"] is List<dynamic>) {
          final messages = response.data["requests"] as List<dynamic>;
          return List<Appeal>.generate(
              messages.length, (index) => Appeal.fromJson(messages[index]));
        }
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    }
    return [];
  }
}
