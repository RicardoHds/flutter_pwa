import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../helpers/translations.dart';

class ConfirmDialog extends StatelessWidget {
  final String title;
  final String content;
  final String button;
  final Function onPress;

  ConfirmDialog({
    @required this.title,
    @required this.content,
    @required this.button,
    @required this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              child: new AlertDialog(
                title: new Text(title.i18n),
                content: new Text(content.i18n),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(child: Text('Ok'), onPressed: onPress)
                ],
              ));
        },
        child: Text(button.i18n));
  }
}
