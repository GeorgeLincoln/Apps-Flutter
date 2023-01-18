import 'package:flutter/material.dart';
import '../widgets/AppBar.dart';

final _formKey = GlobalKey<FormState>();

class Relatorio extends StatefulWidget {
  @override
  _RelatorioState createState() => _RelatorioState();
}

class _RelatorioState extends State<Relatorio> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _formKey,
      appBar: appbar.getAppBar(context),
      body: TextFormField(decoration: InputDecoration.collapsed(hintText: "Faça o relatório da viagem")),
    );
  }
}
