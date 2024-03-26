import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:rzd/features/auth/data/model/user_api.dart';
import 'package:rzd/features/auth/domain/entity/user_model.dart';
import 'package:rzd/features/auth/domain/repository/auth_repository.dart';
import 'package:rzd/core/api_error.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<UserProfile?> login(String email, String password) async {
    Dio dio = Dio(
      BaseOptions(
        headers: {
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    try {
      final response = await dio.post(
        loginUrl,
        data: FormData.fromMap({
          'login': email,
          'password': password,
        }),
      );
      final String? uuid = response.data['uuid'];
      final String? cookie = response.headers['Set-Cookie']?.first;
      log(cookie.toString());
      //Сохраняем наши Credentials в SharedPreferences
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('email', email);
      await preferences.setString('password', password);
      if (cookie != null) {
        await preferences.setString('cookie', cookie);
      }

      if (uuid != null) {
        await preferences.setString('uuid', uuid);
      }
      dio = Dio(
        BaseOptions(
          headers: {
            'Cookie': cookie,
          },
        ),
      );
      final userResponse = await dio.get(
        userProfile,
        queryParameters: {
          'uuid': uuid,
        },
      );
      if (userResponse.data != null) {
        UserProfile userProfile =
            UserProfileApi.fromMap(userResponse.data as Map<String, dynamic>);
        return userProfile;
      }
    } on DioException catch (e) {
      log(e.response.toString());
      throw ApiError(message: "Ошибка авторизации!");
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<bool> logout(String email, String password) async {
    Dio dio = Dio();
    try {
      final response = await dio.post(
        logoutUrl,
        data: FormData.fromMap({
          'login': email,
          'password': password,
        }),
      );
      if (response.statusCode == 200) {
        //Удаляем наши Credentials в SharedPreferences
        SharedPreferences preferences = await SharedPreferences.getInstance();
        await preferences.remove('email');
        await preferences.remove('password');
        return true;
      }
    } on DioException catch (e) {
      log(e.response.toString());
      throw ApiError(message: "Ошибка авторизации!");
    } catch (e) {
      log(e.toString());
      throw ApiError(message: "Ошибка авторизации!");
    }
    return false;
  }

  @override
  Future<void> checkStatus(String fam, String name, String otch,
      DateTime birthday, String passSeries, String passNumber) async {
    Dio dio;
    SharedPreferences preferences = await SharedPreferences.getInstance();

    String? cookie = await preferences.getString('cookie');

    String? uuid = await preferences.getString('uuid');

    dio = Dio();
    try {
      final response = await dio.get(
        checkStatusUrl,
        queryParameters: {
          'fam': fam,
          'name': name,
          'otch': otch,
          'birthday': birthday,
          'pass_series': passSeries,
          'pass_number': passNumber,
        },
      );
      final String? cookie = response.headers['Set-Cookie']?.first;
      log(cookie.toString());
      //Сохраняем наши Credentials в SharedPreferences
      SharedPreferences preferences = await SharedPreferences.getInstance();
      if (cookie != null) {
        await preferences.setString('cookie', cookie);
      }
      if (response.data['status'] != null) {
        if (response.data['status'] != 0) {
          throw Exception();
        } else {
          String? uuid = response.data['uuid'];
          if (uuid != null) {
            await preferences.setString('uuid', uuid);
          }
        }
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> register(
      String login, String password, String rePassword, String uuid) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final cookie = preferences.getString('cookie');
    Dio dio = Dio(
      BaseOptions(
        headers: {
          "Cookie": cookie,
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    try {
      await dio.post(
        registerUrl,
        data: FormData.fromMap(
          {
            'login': login,
            'password': password,
            're_password': rePassword,
            'uuid': uuid,
          },
        ),
      );
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<bool?> checkOtp(String uuid, String otp) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final cookie = preferences.getString('cookie');
    final uid = preferences.getString('uid');
    Dio dio = Dio(
      BaseOptions(
        queryParameters: {
          'uuid': uuid,
        },
        headers: {
          "Content-Type": "multipart/form-data",
          "Cookie": cookie,
        },
      ),
    );

    try {
      final response = await dio.post(
        checkCode,
        data: FormData.fromMap({
          'uid': uid,
          'code': otp,
        }),
      );
      if (response.data['result'] != null) {
        return response.data['result'] as bool;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  @override
  Future<void> sentOtp(String uuid, String phone) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    final cookie = sharedPreferences.getString('cookie');
    Dio dio = Dio(
      BaseOptions(
        queryParameters: {
          'uuid': uuid,
        },
        headers: {
          "Cookie": cookie,
          "Content-Type": "multipart/form-data",
        },
      ),
    );
    try {
      final response = await dio.post(sentOtpUrl,
          data: FormData.fromMap({
            'phone': phone,
          }));

      if (response.data['code'] != null) {
        log("Code - ${response.data['code']}");
      }
      if (response.data['uid'] != null) {
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('uid', response.data['uid'] as String);
        return response.data['uid'];
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
