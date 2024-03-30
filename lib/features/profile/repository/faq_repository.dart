import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/shared_manager.dart';
import 'package:rzd/features/profile/model/faq_info.dart';

class FaqRepository {
  Future<List<FaqInfo>> getFaqs() async {
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
        faqListUrl,
        queryParameters: {
          'uuid': uuid,
        },
      );
      if (response.data is List<dynamic>) {
        final privileges = response.data as List<dynamic>;
        return List.generate(
            privileges.length, (index) => FaqInfo.fromJson(privileges[index]));
      }
    } catch (e) {
      log(e.toString());
    }

    return [];
  }
}
