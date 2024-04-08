import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/shared_manager.dart';

class SupportRepository {
  Future<void> sendForm(String topic, String request, File? doc) async {
    try {
      String? uuid = await SharedManager.getuuid();
      String? cookie = await SharedManager.getCookie();
      Dio dio = Dio(
        BaseOptions(
          headers: {
            'Cookie': cookie,
          },
        ),
      );
      String resString = '';
      final res = doc?.readAsBytesSync();
      if (res != null) {
        resString = base64Encode(res.toList());
      }

      final response = await dio.post(feedbackUrl,
          queryParameters: {
            'uuid': uuid,
          },
          data: FormData.fromMap(
              {'subject': topic, 'body': request, 'filename': resString}));
    } catch (e) {
      log(e.toString());
    }
  }
}
