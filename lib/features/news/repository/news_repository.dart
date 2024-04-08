import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/shared_manager.dart';
import 'package:rzd/features/news/model/new_info.dart';

class NewsRepository {
  Future<List<NewInfo>> getNews() async {
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
        newsUrl,
        queryParameters: {
          'uuid': uuid,
        },
      );
      if (response.data is List<dynamic>) {
        final privileges = response.data as List<dynamic>;

        var list = List.generate(
            privileges.length, (index) => NewInfo.fromJson(privileges[index]));

        return list;
      }
    } catch (e) {
      log(e.toString());
    }

    return [];
  }
}
