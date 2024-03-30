import 'package:shared_preferences/shared_preferences.dart';

class SharedManager {
  static Future<String> getCookie() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final res = preferences.getString('cookie');
    return Future.value(res);
  }

  static Future<String> getuuid() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final res = preferences.getString('uuid');
    return Future.value(res);
  }
}
