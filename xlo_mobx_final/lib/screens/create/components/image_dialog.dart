import 'package:flutter/material.dart';
import 'package:xlo_mobx/components/replace_flatbutton.dart';

class ImageDialog extends StatelessWidget {
  ImageDialog({@required this.image, @required this.onDelete});

  final dynamic image;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.file(image),
          ReplaceFlatButton(
              child: const Text('Excluir'),
              textColor: Colors.red,
              onPressed: () {
                Navigator.of(context).pop();
                onDelete();
              })
        ],
      ),
    );
  }
}
