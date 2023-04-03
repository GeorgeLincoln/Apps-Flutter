import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/replace_flatbutton.dart';

class DialogPlatform extends StatelessWidget {
  final String title;
  final String content;
  final String textNoButton;
  final String textYesButton;
  final Function actionNo;
  final Function actionYes;

  DialogPlatform(
      {@required this.title,
      @required this.content,
      @required this.textNoButton,
      @required this.textYesButton,
      @required this.actionNo,
      @required this.actionYes});

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS)
      return CupertinoAlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          CupertinoDialogAction(
              child: Text(textNoButton),
              isDefaultAction: true,
              onPressed: actionNo),
          CupertinoDialogAction(
            child: Text(textYesButton),
            onPressed: actionYes,
          )
        ],
      );
    else
      return AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          ReplaceFlatButton(
            child: Text(textNoButton),
            textColor: Colors.purple,
            onPressed: actionNo,
          ),
          ReplaceFlatButton(
            child: Text(textYesButton),
            textColor: Colors.purple,
            onPressed: actionYes,
          ),
        ],
      );
  }
}
