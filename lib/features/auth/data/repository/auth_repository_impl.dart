import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/features/auth/domain/repository/auth_repository.dart';
import 'package:rzd/features/core/api_error.dart';
import 'package:rzd/features/core/endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<String?> login(String email, String password) async {
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
      //Сохраняем наши Credentials в SharedPreferences
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString('email', email);
      await preferences.setString('password', password);

      if (uuid != null) {
        await preferences.setString('uuid', uuid);
      }
      return uuid;
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
