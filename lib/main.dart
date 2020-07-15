import 'package:flutter/material.dart';
import 'package:login/helpers/session.dart';
import 'package:login/locator.dart';
import 'package:login/router.dart' as router;
import 'package:login/constants/route_paths.dart' as routers;

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vitro',
        onGenerateRoute: router.generateRoute,
        initialRoute: isSigned() ? routers.HomeRoute : routers.LoginRoute);
  }
}
