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
          "Content-Type": "application/x-www-form-urlencoded",
        },
      ),
    );
    try {
      final response = await dio.post(
        loginUrl,
        data: {
          'login': email,
          'password': password,
        },
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
        data: {
          'login': email,
          'password': password,
        },
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
}
