import 'dart:developer';
import 'dart:io';
import 'package:open_filex/open_filex.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rzd/core/endpoints.dart';
import 'package:rzd/core/shared_manager.dart';
import 'package:rzd/features/documents/model/app_document.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DocumentRepository {
  Future<List<AppDocument>> getFileList() async {
    final uuid = await SharedManager.getuuid();
    final cookie = await SharedManager.getCookie();

    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Cookie': cookie,
        },
      ),
    );
    try {
      final response = await dio.get(
        docsUrl,
        queryParameters: {
          'uuid': uuid,
        },
      );

      final data = response.data as List<dynamic>;
      return List<AppDocument>.generate(
          data.length, (index) => AppDocument.fromJson(data[index]));
    } catch (e) {
      log(e.toString());
    }
    return [];
  }

  Future<String> getSingleFile(int id) async {
    final uuid = await SharedManager.getuuid();
    final cookie = await SharedManager.getCookie();

    Dio dio = Dio(
      BaseOptions(
        headers: {
          'Cookie': cookie,
        },
      ),
    );
    try {
      final Directory? downloadsDir = await getApplicationDocumentsDirectory();
      final response = await dio.get(
        docsLinkUrl,
        options: Options(responseType: ResponseType.bytes),
        queryParameters: {
          'uuid': uuid,
          'document_id': id,
        },
      );
      File file = File('/storage/emulated/0/Download/$id.pdf');
      await file.writeAsBytes(response.data);
      OpenFilex.open('/storage/emulated/0/Download/$id.pdf');
      return '$downloadsDir/$id.pdf';
    } catch (e) {
      log(e.toString());
    }
    return '';
  }
}
