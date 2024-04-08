import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/shared_manager.dart';
import 'package:rzd/features/home/data/model/privileges_api.dart';
import 'package:rzd/features/home/domain/entity/privilege_info.dart';
import 'package:rzd/features/home/domain/entity/privileges.dart';
import 'package:rzd/features/home/domain/repository/privileges_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivilegesRepositoryImpl extends PrivilegesRepository {
  @override
  Future<List<Privileges>> getPrivileges() async {
    String? uuid = await SharedManager.getuuid();
    String? cookie = await SharedManager.getCookie();
    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Cookie': cookie,
        },
      ),
    );
    try {
      final response = await dio.get(
        privilegesDetail,
        queryParameters: {
          'uuid': uuid,
        },
      );
      if (response.data is List<dynamic>) {
        final privileges = response.data as List<dynamic>;
        var list = List.generate(privileges.length,
            (index) => PrivilegesApi.fromMap(privileges[index]));

        return list;
      }
    } catch (e) {
      log(e.toString());
    }

    return [];
  }

  Future<PrivilegeInfo?> getPrivilegeInfo(String type) async {
    String? uuid = await SharedManager.getuuid();
    String? cookie = await SharedManager.getCookie();
    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Cookie': cookie,
        },
      ),
    );
    try {
      final response = await dio.get(
        privilegesDetail,
        queryParameters: {
          'uuid': uuid,
          'type': type,
        },
      );

      return PrivilegeInfo.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
    }
  }
}
