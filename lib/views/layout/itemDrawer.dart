import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../helpers/translations.dart';

class ItemDrawer extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onPress;

  ItemDrawer({
    @required this.label,
    this.icon,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label.i18n),
      onTap: () {
        onPress();
        Navigator.pop(context);
      },
    );
  }
}
