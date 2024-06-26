import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/shared_manager.dart';
import 'package:rzd/features/benifits/model/teeth_form.dart';

class TeethRepository {
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
        teethCheckUrl,
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

  Future<Map<String, dynamic>> getNuzList() async {
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
        teethNuzListUrl,
        queryParameters: {
          'uuid': uuid,
        },
      );
      final data = response.data as Map<String, dynamic>;
      return data;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> sendRequest(TeethForm form) async {
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
      await dio.post(
        teethRequestUrl,
        queryParameters: {
          'uuid': uuid,
        },
        data: FormData.fromMap(
          form.toMap(),
        ),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return false;
  }
}
