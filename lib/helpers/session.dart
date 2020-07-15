import 'package:shared_preferences/shared_preferences.dart';

class HelpersSession {
  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    return token;
  }

  bool isSigned() {
    final token = getToken();
    return token != null ? true : false;
  }
}
