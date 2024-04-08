import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/extensions.dart';
import 'package:rzd/core/shared_manager.dart';
import 'package:rzd/features/home/data/model/append.dart';

class AppendRepository {
  Future<List<Append>> getAppendList() async {
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
        appendListUrl,
        queryParameters: {
          'uuid': uuid,
        },
      );
      final data = response.data as Map<String, dynamic>;
      final List<Append> result = [];
      for (var i = 0; i < data.length; i++) {
        result.add(
          Append.fromJson(
            data.keys.toList()[i],
            (data.values.toList()[i] as String?)?.parseHtmlString() ?? '',
          ),
        );
      }
      return result;
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<void> sendRequest(String id, String? comment, File? file) async {
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
      String fileStr = '';
      final res = file?.readAsBytesSync();
      if (res != null) {
        fileStr = base64Encode(res.toList());
      }
      final response = await dio.post(
        appendRequestUrl,
        queryParameters: {
          'uuid': uuid,
        },
        data: FormData.fromMap(
          {
            'application': int.parse(id),
            'comment': comment,
            'filename': fileStr,
          },
        ),
      );
    } catch (e) {
      log(e.toString());
    }
  }
}
