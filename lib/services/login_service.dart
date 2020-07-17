import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:login/constants/urls.dart';
import 'package:dio/dio.dart';
import 'package:login/helpers/http_client.dart';
import 'package:login/locator.dart';

class LoginService {
  // var dio = Dio();

  HttpClient client = locator<HttpClient>();
  Future<dynamic> signIn(Map<String, String> body) async {
    var _url = api + 'integration/customer/token';

    // final http.Response response = await http.post(_url,
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //     },
    //     body: jsonEncode(body));

    final response = client.post(_url, body: jsonEncode(body));

    return response;
  }
}
