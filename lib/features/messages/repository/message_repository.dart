import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/features/messages/model/message.dart';
import 'package:rzd/features/messages/view/bloc/message_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageRepository {
  Future<List<Message>> getMessages() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final uuid = preferences.getString('uuid');
    final cookie = preferences.getString('cookie');
    if (uuid != null && cookie != null) {
      Dio dio = Dio(
        BaseOptions(
          headers: {
            'Cookie': cookie,
          },
        ),
      );
      try {
        final response = await dio.get(
          getMessagesUrl,
          queryParameters: {
            'uuid': uuid,
          },
        );
        if (response.data["messages"] is List<dynamic>) {
          final messages = response.data["messages"] as List<dynamic>;
          return List<Message>.generate(
              messages.length, (index) => Message.fromJson(messages[index]));
        }
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    }
    return [];
  }

  Future<void> tickAllMessages() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final uuid = preferences.getString('uuid');
    final cookie = preferences.getString('cookie');
    if (uuid != null && cookie != null) {
      Dio dio = Dio(
        BaseOptions(
          headers: {
            'Cookie': cookie,
          },
        ),
      );
      try {
        final response = await dio.get(
          tickAllMessagesUrl,
          queryParameters: {
            'uuid': uuid,
          },
        );
      } catch (e) {
        log(e.toString());
        rethrow;
      }
    }
  }
}
