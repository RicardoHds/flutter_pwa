import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:i18n_extension/i18n_widget.dart';
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
          ListTile(
            leading: Icon(Icons.center_focus_weak),
            title: Text('QR Code Scanner'.i18n),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.flag),
            title: Text('English'.i18n),
            onTap: _changeLanguage,
          ),
        ],
      ),
    );
  }
}
