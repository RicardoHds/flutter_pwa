import 'package:shared_preferences/shared_preferences.dart';

class HelpersSession {
  final String _token = "token";

  Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString(_token) ?? '';
  }

  Future<bool> isSigned() async {
    final log = await getToken();
    return log.isEmpty ? false : true;
  }

  void logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
  }
}
