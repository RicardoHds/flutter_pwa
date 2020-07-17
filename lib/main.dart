import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:login/helpers/session.dart';
import 'package:login/router.dart' as router;
import 'package:login/constants/route_paths.dart' as routers;
import 'package:login/locator.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  bool _isSigned = await HelpersSession().isSigned();

  if (_isSigned) {
    runApp(MainApp(isLogged: true));
  } else {
    runApp(MainApp(isLogged: false));
  }
}

class MainApp extends StatefulWidget {
  final isLogged;
  const MainApp({Key key, this.isLogged}) : super(key: key);
  @override
  _MainApp createState() => _MainApp();
}

class _MainApp extends State<MainApp> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale("en", "US"),
        const Locale("es", "MX"),
      ],
      debugShowCheckedModeBanner: false,
      title: 'Vitro',
      onGenerateRoute: router.generateRoute,
      initialRoute: widget.isLogged ? routers.HomeRoute : routers.LoginRoute,
    );
  }
}
