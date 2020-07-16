import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/views/home_view.dart';
import 'package:login/views/layout/mainDrawer.dart';
import 'package:login/views/login_view.dart';
import '../../helpers/translations.dart';

class Layout extends StatelessWidget {
  final bool isLogged;

  Layout({
    @required this.isLogged,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(title: Text("Language".i18n)),
      drawer: MainDrawer(),
      body: isLogged ? HomeView() : LoginView(),
    );
  }
}
