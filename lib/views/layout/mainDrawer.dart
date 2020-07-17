import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
import 'package:login/views/layout/itemDrawer.dart';
import '../../helpers/translations.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _changeLanguage() => I18n.of(context).locale =
        (I18n.localeStr == "es_mx") ? Locale("en", "US") : Locale("es", "MX");

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text('Welcome'.i18n),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ItemDrawer(
            label: 'QR Code Scanner',
            icon: Icons.center_focus_weak,
            onPress: () {},
          ),
          ItemDrawer(
            label: 'English',
            icon: Icons.flag,
            onPress: _changeLanguage,
          ),
        ],
      ),
    );
  }
}
