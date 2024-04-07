import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/features/home/data/model/app_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppInfoRepository {
  Future<AppInfo?> getInfo() async {
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
          infoUrl,
          queryParameters: {
            'uuid': uuid,
          },
        );
        return AppInfo.fromJson(response.data as Map<String, dynamic>);
      } catch (e) {
        log(e.toString());
      }
    }
  }
}
