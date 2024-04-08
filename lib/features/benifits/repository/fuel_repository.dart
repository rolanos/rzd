import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/shared_manager.dart';
import 'package:rzd/features/benifits/model/fuel_form.dart';
import 'package:rzd/features/benifits/model/fuel_type.dart';
import 'package:rzd/features/benifits/model/sankur_form.dart';
import 'package:rzd/features/benifits/model/sanprof.dart';

class FuelRepository {
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
        fuelCheckUrl,
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

  Future<List<FuelType>> getFuelTypeList() async {
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
        fuelListUrl,
        queryParameters: {
          'uuid': uuid,
        },
      );
      final data = response.data as Map<String, dynamic>;
      return List.generate(data.values.length,
          (index) => FuelType.fromJson(data.values.toList()[index]));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> sendRequest(FuelForm form) async {
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
      final response = await dio.get(fuelRequestUrl,
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
