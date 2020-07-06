import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController alturaController = TextEditingController();
  TextEditingController pesoController = TextEditingController();

  GlobalKey<FormState> _chaveGlobal = GlobalKey<FormState>();

  String _infoText = "Informe seus Dados";

  void _resetarFilhos() {
    pesoController.text = "";
    alturaController.text = "";
    setState(() {
      _infoText = "Informe seus Dados";
<<<<<<< HEAD
=======
       _formKey = GlobalKey<FormState>();
>>>>>>> ac38ff69c3a00078a7884c383d6fbb243d7ec2bf
    });
  }

  void _calcular() {
    setState(() {
      // isso é para recaregar a tela passando as novas informações
      double peso = double.parse(pesoController.text);
      double altura =
          // divide por 100 para transformar de metros para sentimetro
          double.parse(alturaController.text) / 100;
      double imc = peso / (altura * altura);

      if (imc < 18.6)
        _infoText = "Abaixo do Peso\n Imc: ${imc.toStringAsPrecision(3)}";
      else if (imc >= 18.6 && imc < 24.9)
        _infoText = "Peso Ideal\n Imc: ${imc.toStringAsPrecision(3)}";
      else if (imc >= 24.9 && imc < 29.9)
        _infoText =
            "Levemente Acima do Peso Ideal\n Imc: ${imc.toStringAsPrecision(3)}";
      else if (imc >= 29.9 && imc < 34.9)
        _infoText = "Obesidade Grau I\n Imc: ${imc.toStringAsPrecision(3)}";
      else if (imc >= 34.9 && imc < 39.9)
        _infoText = "Obesidade Grau II\n Imc: ${imc.toStringAsPrecision(3)}";
      else if (imc >= 40)
        _infoText = "Obesidade Grau III\n Imc: ${imc.toStringAsPrecision(3)}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Calculadora de IMC"),
          centerTitle: true,
          backgroundColor: Colors.green,
          actions: [
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: _resetarFilhos,
            )
          ],
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
            padding: EdgeInsets.fromLTRB(10, 0.0, 10, 0.0),
            child: Form(
              key: _chaveGlobal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Icon(
                    Icons.person_outline,
                    size: 120.0,
                    color: Colors.green,
                  ),
                  TextFormField(
                    controller: pesoController,
                    validator: (value) {
                      if (value.isEmpty) return "Insira seu peso";
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Peso (Kg)",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                    ),
                  ),
                  TextFormField(
                    controller: alturaController,
                    validator: (value) {
                      if (value.isEmpty) return "Insira sua altura";
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.green),
                    ),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 16.0,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      height: 40.0,
                      child: RaisedButton(
                        onPressed: () {
                          //caso a chave global estiver válida, calcula.
                          if (_chaveGlobal.currentState.validate()) _calcular();
                        },
                        child: Text(
                          "Calcular",
                          style: TextStyle(color: Colors.white, fontSize: 17.0),
                        ),
                        color: Colors.green,
                      ),
                    ),
                  ),
                  Text(_infoText,
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.green, fontSize: 17.0)),
                ],
              ),
<<<<<<< HEAD
            )));
=======
            )
        )
    );
>>>>>>> ac38ff69c3a00078a7884c383d6fbb243d7ec2bf
  }
}
