import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/features/core/endpoints.dart';
import 'package:rzd/features/home/data/model/privileges_api.dart';
import 'package:rzd/features/home/domain/entity/privileges.dart';
import 'package:rzd/features/home/domain/repository/privileges_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivilegesRepositoryImpl extends PrivilegesRepository {
  @override
  Future<List<Privileges>> getPrivileges() async {
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
          privilegesUrl,
          queryParameters: {
            'uuid': uuid,
          },
        );
        if (response.data["privileges"] is List<dynamic>) {
          final privileges = response.data["privileges"] as List<dynamic>;
          return List.generate(privileges.length,
              (index) => PrivilegesApi.fromMap(privileges[index]));
        }
      } catch (e) {
        log(e.toString());
      }
    }

    return [];
  }
}
