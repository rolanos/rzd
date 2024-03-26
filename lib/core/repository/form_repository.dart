import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/model/form_data_class.dart';
import 'package:rzd/core/model/form_general.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormRepository {
  Future<List<FormGeneral>> getForms() async {
    Dio dio;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? cookie = preferences.getString('cookie');

    String? uuid = preferences.getString('uuid');

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
        formList,
        queryParameters: {
          'uuid': uuid,
        },
      );

      return List.generate((response.data['forms'] as List).length,
          (index) => FormGeneral.fromJson(response.data['forms'][index]));
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<FormDataClass> getFormDescription(String formKey) async {
    Dio dio;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? cookie = preferences.getString('cookie');

    String? uuid = preferences.getString('uuid');

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
        formDescription,
        queryParameters: {
          'uuid': uuid,
          'form_key': formKey,
        },
      );

      return FormDataClass.fromJson(response.data as Map<String, dynamic>);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
