import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  final title;
  final content;
  final button;
  final Function onConfirmPress;

  ConfirmDialog(
      {@required this.title,
      @required this.content,
      @required this.button,
      @required this.onConfirmPress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              child: new AlertDialog(
                title: new Text(title),
                content: new Text(content),
                actions: <Widget>[
                  FlatButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(child: Text('Ok'), onPressed: onConfirmPress)
                ],
              ));
        },
        child: Text(button));
  }
}
