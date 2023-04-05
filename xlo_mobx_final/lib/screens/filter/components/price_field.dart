import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceField extends StatelessWidget {
  PriceField({this.label, this.onChanged, this.initialValue});

  final String label;
  final Function(int) onChanged;
  final int initialValue;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextFormField(
        decoration: InputDecoration(
          prefixText: 'R\$ ',
          border: OutlineInputBorder(),
          isDense: true,
          labelText: label,
        ),
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          RealInputFormatter(centavos: false)
        ],
        keyboardType: TextInputType.number,
        style: TextStyle(
          fontSize: 16,
        ),
        onChanged: (text) {
          onChanged(int.tryParse(text.replaceAll('.', '')));
        },
        initialValue: initialValue?.toString(),
      ),
    );
  }
}
