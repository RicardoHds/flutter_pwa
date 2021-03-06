import 'package:flutter/material.dart';
import 'package:login/views/layout/mainDrawer.dart';
import '../../helpers/translations.dart';

class MainLayout extends StatelessWidget {
  final String title;
  final Widget children;

  MainLayout({
    this.title = '',
    @required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[100],
      appBar: AppBar(title: Text(title.i18n)),
      drawer: MainDrawer(),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: children,
          ),
        ),
      ),
    );
  }
}
