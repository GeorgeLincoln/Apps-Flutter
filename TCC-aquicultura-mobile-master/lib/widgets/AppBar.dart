import 'package:aquicultura_transporte/tabs/MainPage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class appbar {
  static AppBar getAppBar(BuildContext context) {
    return new AppBar(
          title: new Text('Move-Aqua'),
          actions: <Widget>[
            IconButton(
                icon: Icon(FontAwesomeIcons.bluetooth),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (contexto) => MainPage()),
                  );
                  //
                }),
          ],
        );
  }
}