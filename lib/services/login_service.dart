import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:login/constants/urls.dart';

class LoginService {
  Future<http.Response> signIn(Map<String, String> body) async {
    var _url = api + 'integration/customer/token';

    final http.Response response = await http.post(_url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));

    return response;
  }
}
