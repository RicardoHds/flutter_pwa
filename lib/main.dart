import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:login/helpers/session.dart';
import 'package:login/router.dart' as router;
import 'package:login/views/home_view.dart';
import 'package:login/views/login_view.dart';

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
  final home;

  MainApp({@required this.isLogged, this.home});

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
      home: I18n(
        child: isLogged ? HomeView() : LoginView(),
        initialLocale: Locale("en", "US"),
      ),
      // initialRoute: isLogged ? routers.HomeRoute : routers.LoginRoute,
    );
  }
}
