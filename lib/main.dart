import 'package:flutter/material.dart';
import 'package:login/helpers/session.dart';
import 'package:login/router.dart' as router;
import 'package:login/constants/route_paths.dart' as routers;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool _isSigned = await HelpersSession().isSigned();

  if (_isSigned) {
    runApp(MainApp(isLogged: true));
  } else {
    runApp(MainApp(isLogged: false));
  }
}

class MainApp extends StatelessWidget {
  final isLogged;

  MainApp({@required this.isLogged});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vitro',
      onGenerateRoute: router.generateRoute,
      initialRoute: isLogged ? routers.HomeRoute : routers.LoginRoute,
    );
  }
}
