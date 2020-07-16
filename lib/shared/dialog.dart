import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:login/helpers/session.dart';

class ConfirmDialog extends StatelessWidget {
  ConfirmDialog(
      {@required this.title, @required this.content, @required this.button});

  final title;
  final content;
  final button;

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
                    }),
                FlatButton(
                    child: Text('Ok'),
                    onPressed: () {
                      HelpersSession().logOut();
                      // _helperSession.logOut();
                      Navigator.of(context).pop();
                    })
              ],
            ));
      },
      child: Text(button),
    );
  }
}
