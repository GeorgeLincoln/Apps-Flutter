import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Container(
          color: Colors.yellow,
        ),
        Container(
          color: Colors.red,
        ),
      ],
    );
  }
}
