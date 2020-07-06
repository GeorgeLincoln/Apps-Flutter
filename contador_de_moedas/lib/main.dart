import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

const request = "https://api.hgbrasil.com/finance?key=1c07c958";

void main() async {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
    theme: ThemeData(
        hintColor: Colors.amber,
        primaryColor: Colors.white,
        inputDecorationTheme: InputDecorationTheme(
          enabledBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
          focusedBorder:
              OutlineInputBorder(borderSide: BorderSide(color: Colors.amber)),
          hintStyle: TextStyle(color: Colors.amber),
        )),
  ));
}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  double dolar;
  final dolarController = TextEditingController();
  double euro;
  final euroController = TextEditingController();
  final realController = TextEditingController();

  void _clearAll() {
    realController.text = "";
    dolarController.text = "";
    euroController.text = "";
  }

  void _realChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double real = double.parse(text);
    dolarController.text = (real / dolar).toStringAsFixed(2);
    euroController.text = (real / euro).toStringAsFixed(2);
  }

  void _dolarChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double dolar = double.parse(text);
    realController.text = (dolar * this.dolar).toStringAsFixed(2);
    euroController.text = (dolar * this.dolar / euro).toStringAsFixed(2);
  }

  void _euroChanged(String text) {
    if (text.isEmpty) {
      _clearAll();
      return;
    }
    double euro = double.parse(text);
    realController.text = (euro * this.euro).toStringAsFixed(2);
    dolarController.text = (euro * this.euro / dolar).toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          // coloca a barra em cima
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("\$ Converter Moedas \$"),
            backgroundColor: Colors.greenAccent,
            centerTitle: true,
          ),
          body: FutureBuilder<Map>(
            future: getData(),
            // ignore: missing_return
            builder: (context, snapshot) {
              var connectionState = snapshot.connectionState;
              switch (connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return Center(
                    child: Text(
                      "Carregando Dados...",
                      style:
                          TextStyle(color: Colors.greenAccent, fontSize: 25.0),
                      textAlign: TextAlign.center,
                    ),
                  );
                case ConnectionState.active:
                // ignore: todo
                // TODO: Handle this case.

                case ConnectionState.done:
                  // ignore: todo
                  // TODO: Handle this case.

                  // ignore: unused_label
                  defaut:
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        "Erro ao Carregar Dados :(",
                        style: TextStyle(
                            color: Colors.greenAccent, fontSize: 25.0),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    dolar =
                        snapshot.data["results"]["currencies"]["USD"]["buy"];
                    euro = snapshot.data["results"]["currencies"]["EUR"]["buy"];

                    return SingleChildScrollView(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            FlatButton(
                                onPressed: _clearAll,
                                child: Icon(Icons.monetization_on,
                                    size: 150.0, color: Colors.greenAccent)),
                            Container(
                                margin: const EdgeInsets.all(15.0),
                                padding: const EdgeInsets.all(3.0),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: Colors.grey[100])),
                                child: Column(
                                  children: [
                                    Padding(padding: EdgeInsets.all(5.0)),
                                    buildTextField("Reais", "R\$ ",
                                        realController, _realChanged),
                                    Divider(),
                                    buildTextField("Dólares", "US\$ ",
                                        dolarController, _dolarChanged),
                                    Divider(),
                                    buildTextField("Euros", "€\$ ",
                                        euroController, _euroChanged),
                                  ],
                                )),
                          ]),
                    );
                  }
              }
            },
          )),
    );
  }
}

Widget buildTextField(
    String label, String prefix, TextEditingController c, Function f) {
  return TextField(
    controller: c,
    decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.green),
        border: OutlineInputBorder(),
        prefixText: prefix),
    style: TextStyle(color: Colors.green, fontSize: 20.0),
    onChanged: f,
    keyboardType: TextInputType.numberWithOptions(decimal: true), //só números
  );
}

Future<Map> getData() async {
  http.Response response = await http.get(request);
  return json.decode(response.body);
}
