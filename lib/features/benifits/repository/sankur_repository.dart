import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/shared_manager.dart';
import 'package:rzd/features/benifits/model/sankur_form.dart';
import 'package:rzd/features/benifits/model/sanprof.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SankurRepository {
  Future<bool> check() async {
    Dio dio;

    String? cookie = await SharedManager.getCookie();

    String? uuid = await SharedManager.getuuid();

    dio = Dio(
      BaseOptions(
        headers: {
          "Cookie": cookie,
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    try {
      final response = await dio.get(
        sankurCheckUrl,
        queryParameters: {
          'uuid': uuid,
        },
      );
      if ((response.data as Map<String, dynamic>).containsKey('status')) {
        if (response.data['status'] == 0) {
          return true;
        }
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return false;
  }

  Future<List<Sanprof>> getSanprofList() async {
    Dio dio;
    String? cookie = await SharedManager.getCookie();

    String? uuid = await SharedManager.getuuid();

    dio = Dio(
      BaseOptions(
        headers: {
          "Cookie": cookie,
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    try {
      final response = await dio.get(
        sankurSanprofListUrl,
        queryParameters: {
          'uuid': uuid,
        },
      );
      final data = response.data as Map<String, dynamic>;
      return List.generate(data.values.length,
          (index) => Sanprof.fromJson(data.values.toList()[index]));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> sendRequest(SankurForm form) async {
    Dio dio;
    String? cookie = await SharedManager.getCookie();

    String? uuid = await SharedManager.getuuid();

    dio = Dio(
      BaseOptions(
        headers: {
          "Cookie": cookie,
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    try {
      final response = await dio.get(sankurRequestUrl,
          queryParameters: {
            'uuid': uuid,
          },
          data: FormData.fromMap(form.toMap()));
      final data = response.data as Map<String, dynamic>;
      if ((response.data as Map<String, dynamic>).containsKey('status')) {
        if (response.data['status'] == 0) {
          return true;
        }
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return false;
  }
}
