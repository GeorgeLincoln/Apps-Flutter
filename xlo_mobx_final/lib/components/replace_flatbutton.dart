import 'package:flutter/material.dart';

class ReplaceFlatButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color textColor;
  final EdgeInsetsGeometry padding;

  ReplaceFlatButton({this.child, this.onPressed, this.textColor, this.padding});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        child: child,
        onPressed: onPressed,
        style: TextButton.styleFrom(
            primary: textColor ?? Theme.of(context).primaryColor,
            padding: padding));
  }
}
