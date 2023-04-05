import 'package:flutter/material.dart';
import 'package:gerente_loja/screens/login_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.pinkAccent
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}