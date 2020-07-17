// import 'package:http/http.dart' as http;
import 'package:login/constants/urls.dart';
// import 'package:login/helpers/session.dart';
import 'package:dio/dio.dart';
import 'package:login/helpers/http_client.dart';
import 'package:login/locator.dart';

class HomeModel {
  var dio = Dio();
  HttpClient client = locator<HttpClient>();
  // HelpersSession _helperSession = HelpersSession();

  Future<dynamic> getUser() async {
    // final token = await _helperSession.getToken();

    var _url = api + 'customers/me';

    // final http.Response response =
    //     await http.get(_url, headers: {'Authorization': 'Bearer $token'});

    // dio.options.headers['content-Type'] = 'application/json';
    // dio.options.headers["authorization"] = "Bearer $token";

    final response = client.get(_url);

    return response;
  }
}
