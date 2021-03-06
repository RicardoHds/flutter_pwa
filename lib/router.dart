import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/constants/route_paths.dart' as routes;
import 'package:login/views/home/home_view.dart';
import 'package:login/views/login/login_view.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case routes.LoginRoute:
      return MaterialPageRoute(builder: (context) => LoginView());
    case routes.HomeRoute:
      return MaterialPageRoute(builder: (context) => HomeView());
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
