import 'package:flutter/material.dart';

class  InputField extends StatelessWidget {
  
  final IconData icon;
  final String hint;
  final bool obscure;
  final Stream<String> stream;
  final Function(String) onChanged;

  InputField({this.hint, this.icon, this.obscure, this.stream, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<String>(
      stream: stream,
      builder: (context, snapshot){
        return TextField(
          onChanged: onChanged,
          decoration: InputDecoration(
          icon: Icon(icon, color: Colors.indigo[700]),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.indigo[700]),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.indigo[700])
          ),
          contentPadding: EdgeInsets.only(
            left: 5,
            right: 20,
            bottom: 20,
            top: 20
          ),
          errorText: snapshot.hasError ? snapshot.error : null,
        ),
        style: TextStyle(color: Colors.indigo[700]),
        obscureText: obscure,
        );
      }
    );
  }
}