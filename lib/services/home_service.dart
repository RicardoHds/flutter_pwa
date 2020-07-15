import 'package:http/http.dart' as http;
import 'package:login/constants/urls.dart';
import 'package:login/helpers/session.dart';

class HomeModel {
  HelpersSession _helperSession = HelpersSession();

  Future<http.Response> getUser() async {
    final token = await _helperSession.getToken();

    var _url = api + 'customers/me';

    final http.Response response =
        await http.get(_url, headers: {'Authorization': 'Bearer $token'});

    return response;
  }
}
