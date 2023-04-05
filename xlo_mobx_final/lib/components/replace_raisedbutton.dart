import 'package:flutter/material.dart';

class ReplaceRaisedButton extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final Color textColor;
  final Color color;
  final Color disabledColor;
  final EdgeInsetsGeometry padding;
  final MaterialTapTargetSize materialTapTargetSize;
  final RoundedRectangleBorder shape;
  final double elevation;

  ReplaceRaisedButton(
      {this.child,
      this.onPressed,
      this.textColor,
      this.padding,
      this.color,
      this.disabledColor,
      this.materialTapTargetSize,
      this.shape,
      this.elevation});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: child,
        onPressed: onPressed,
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(padding),
            foregroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.disabled)
                      ? disabledColor
                      : textColor,
            ),
            backgroundColor: MaterialStateProperty.resolveWith<Color>(
              (Set<MaterialState> states) =>
                  states.contains(MaterialState.disabled)
                      ? disabledColor
                      : color,
            ),
            shape: MaterialStateProperty.all(shape),
            elevation: MaterialStateProperty.all<double>(elevation),
            tapTargetSize: materialTapTargetSize));
  }
}
