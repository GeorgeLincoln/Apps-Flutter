import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/replace_flatbutton.dart';

class LocationInfoDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final title = Center(
      child: Text(
        'Localização automática',
        style: TextStyle(color: Colors.purple),
      ),
    );
    final content = Text('Permita o acesso à localização do aparelho para ficar'
        ' mais fácil visualizar anúncios na sua região.');
    final textOKButton = const Text('OK');
    final actionOK = () => Navigator.of(context).pop();

    if (Platform.isIOS)
      return CupertinoAlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          CupertinoDialogAction(
              child: textOKButton, isDefaultAction: true, onPressed: actionOK),
        ],
      );
    else
      return AlertDialog(
        title: title,
        content: content,
        actions: <Widget>[
          ReplaceFlatButton(
            child: textOKButton,
            textColor: Colors.purple,
            padding: EdgeInsets.zero,
            onPressed: actionOK,
          )
        ],
      );
  }
}
