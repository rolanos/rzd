import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/shared_manager.dart';
import 'package:rzd/features/news/model/new_info.dart';

class NewsRepository {
  Future<List<NewInfo>> getNews() async {
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
        newsUrl,
        queryParameters: {
          'uuid': uuid,
        },
      );
      if (response.data is List<dynamic>) {
        final privileges = response.data as List<dynamic>;
        Dio dioImg = Dio(
          BaseOptions(
            headers: {
              'Cookie': cookie,
              'Content-type': 'image/jpeg',
            },
          ),
        );
        var list = List.generate(
            privileges.length, (index) => NewInfo.fromJson(privileges[index]));
        for (var i = 0; i < list.length; i++) {
          final image = await dioImg.get(
            newImageUrl,
            queryParameters: {
              'uuid': uuid,
              'content_id': list[i].contentId,
            },
          );
          // final documentDirectory = await getApplicationDocumentsDirectory();
          // File file =
          //     File(join(documentDirectory.path, list[i].contentId.toString()));
          // file.writeAsBytesSync(base64Decode(image.data));
          list[i] = list[i].copyWithImage(imageBinary: null);
        }
        return list;
      }
    } catch (e) {
      log(e.toString());
    }

    return [];
  }
}
