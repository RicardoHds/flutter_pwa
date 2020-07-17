import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/translations.dart';

class Button extends StatelessWidget {
  final String label;
  final bool isRounded;
  final bool indicator;
  final Function onPress;

  Button({
    @required this.label,
    @required this.onPress,
    this.isRounded = true,
    this.indicator = false,
  });

  @override
  Widget build(BuildContext context) {
    return indicator
        ? Padding(
            padding: EdgeInsets.all(10.0), child: CircularProgressIndicator())
        : ButtonTheme(
            minWidth: 250.0,
            height: 50.0,
            child: FlatButton(
              shape: isRounded
                  ? RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0))
                  : RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0.0)),
              color: Color.fromRGBO(0, 201, 220, 1),
              textColor: Colors.white,
              onPressed: onPress,
              child: Text(label.i18n),
            ),
          );
  }
}
