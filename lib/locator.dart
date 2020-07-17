import 'package:get_it/get_it.dart';
import 'package:login/services/login_service.dart';
import 'package:login/services/home_service.dart';
import 'package:login/helpers/http_client.dart';

GetIt locator = GetIt.instance;

// void setupLocator() {

// }

Future<void> setupLocator() async {
  //Components
  locator.registerSingleton(HttpClient());

  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => LoginService());
}
