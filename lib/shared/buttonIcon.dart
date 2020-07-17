import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/translations.dart';

class ButtonIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final Function onPress;

  ButtonIcon({
    @required this.icon,
    @required this.onPress,
    this.label,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Row(mainAxisSize: MainAxisSize.max, children: [
        Icon(
          icon,
          color: color,
          size: 50.0,
        ),
        Text(
          label.i18n,
          textAlign: TextAlign.left,
          style: TextStyle(color: color),
        )
      ]),
    );
  }
}
