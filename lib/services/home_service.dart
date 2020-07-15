import 'package:http/http.dart' as http;
import 'package:login/constants/urls.dart';

class HomeModel{
  Future<http.Response> getUser(String token)async{
    
    var _url = api + 'customers/me';

    final http.Response response = await http.get(_url, headers: {'Authorization': 'Bearer $token'});

    return response;
  }
}