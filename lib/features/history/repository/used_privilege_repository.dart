import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/features/history/model/appeal.dart';
import 'package:rzd/features/history/model/privilege.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UsedPrivilegeRepository {
  Future<List<UsedPrivilege>> getUsedPrivileges() async {
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
          getPrivilegesUrl,
          queryParameters: {
            'uuid': uuid,
          },
        );
        if (response.data["privileges_used"] is List<dynamic>) {
          final messages = response.data["privileges_used"] as List<dynamic>;
          return List<UsedPrivilege>.generate(messages.length,
              (index) => UsedPrivilege.fromJson(messages[index]));
        }
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    }
    return [];
  }
}
