import 'dart:convert';
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

      final list = List.generate((response.data['forms'] as List).length,
          (index) => FormGeneral.fromJson(response.data['forms'][index]));

      for (var i = 0; i < list.length; i++) {
        final responseImage = await dio.get(
          '$baseUrl/images/',
          queryParameters: {
            'formtype': list[i].formKey,
          },
        );
        String? image;
        switch (list[i].formName) {
          case 'Форма заказа справок':
            image = (responseImage.data as Map<String, dynamic>)['order']
                ['images']['medium'];
            break;
          case 'Комиссия по благотворительной помощи':
            image = (responseImage.data as Map<String, dynamic>)['charity']
                ['images']['medium'];
            break;
          case 'Обращение в БФ «ПОЧЕТ»':
            image = (responseImage.data as Map<String, dynamic>)['pochet']
                ['images']['medium'];
            break;
          case 'Нормативные документы':
            image = (responseImage.data as Map<String, dynamic>)['docs']
                ['images']['medium'];
            break;
        }
        list[i].image = image;
      }
      return list;
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

      final info =
          FormDataClass.fromJson(response.data as Map<String, dynamic>);

      return info;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<bool> validateForm(String formKey, Map<String, dynamic> data) async {
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
      final response = await dio.post(formValidate,
          queryParameters: {
            'uuid': uuid,
          },
          data: FormData.fromMap(
              {"form_key": formKey, "form_data": json.encode(data)}));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return false;
  }

  Future<bool> sendForm(String formKey, Map<String, dynamic> data) async {
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
      final response = await dio.post(formSend,
          queryParameters: {
            'uuid': uuid,
          },
          data: FormData.fromMap(
              {"form_key": formKey, "form_data": json.encode(data)}));

      if (response.statusCode == 200) {
        return true;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
    return false;
  }
}
