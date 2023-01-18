import 'package:flutter/material.dart';
import './telas/login_tela.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
 @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Transporte-Aquicultura',
      theme: ThemeData(
        primaryColor: Colors.indigo[700]
      ),
      debugShowCheckedModeBanner: true,
      home: LoginTela(),
    );
  }
}