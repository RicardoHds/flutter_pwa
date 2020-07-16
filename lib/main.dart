import 'package:flutter/material.dart';
import 'package:login/helpers/session.dart';
import 'package:login/router.dart' as router;
import 'package:login/constants/route_paths.dart' as routers;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _isSigned = await HelpersSession().isSigned();

  if (_isSigned) {
    runApp(LoggedApp());
  } else {
    runApp(UnLoggedApp());
  }
}

class LoggedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vitro',
        onGenerateRoute: router.generateRoute,
        initialRoute: routers.HomeRoute);
  }
}

class UnLoggedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Vitro',
        onGenerateRoute: router.generateRoute,
        initialRoute: routers.LoginRoute);
  }
}
