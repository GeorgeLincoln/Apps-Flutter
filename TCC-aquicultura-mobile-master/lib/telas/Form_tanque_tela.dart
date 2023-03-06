import 'package:aquicultura_transporte/validators/firebase_validators.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class FormTanque extends StatefulWidget {
  @override
  _FormTanqueState createState() => new _FormTanqueState();
}

class _FormTanqueState extends State<FormTanque> {
  bool _temp = false;
  bool _oxi = false;
  bool _num_Temp = false;
  bool _num_Oxi = false;
  bool _saving = false;
  int tanque = 1;
//os dados de temperatura e oxigenio devem vir do Firebase
  double temp = 29.6;
  double oxi = 12.5;

  var tanques = [
    'Tanque ',
    'Tanque  ',
    'Tanque ',
    'Tanque ',
    'Tanque  ',
    'Tanque '
  ];

  void _submit() {
    print('Criando Tanque $tanque...');
    createTanque(tanque, temp, oxi);
    getTanque(tanque);
    //getID(tanque);
    tanque++;

    setState(() {
      _saving = true;
    });

    //Simulate a service call
    print('submitting to backend...');
    new Future.delayed(new Duration(seconds: 2), () {
      setState(() {
        _saving = false;
      });
    });
  }

  List<Widget> _buildForm(BuildContext context) {
    Form form = new Form(
      child: new Column(
        children: [
          new SwitchListTile(
            title: const Text('Temperatura'),
            value: _num_Temp,
            onChanged: (bool value) {
              setState(() {
                _num_Temp = value;
              });
            },
            secondary: const Icon(Icons.wb_sunny),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.format_list_numbered_rtl),
                hintText: 'Número do sensor',
                contentPadding: const EdgeInsets.only(right: 100.0),
              ),
            ),
          ),
          new SwitchListTile(
            title: const Text('Oxigênio'),
            value: _num_Oxi,
            onChanged: (bool value) {
              setState(() {
                _num_Oxi = value;
              });
            },
            secondary: const Icon(Icons.graphic_eq),
          ),
          Padding(
            padding: EdgeInsets.only(left: 30),
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                border: InputBorder.none,
                icon: Icon(Icons.format_list_numbered_rtl),
                hintText: 'Número do sensor',
                contentPadding: const EdgeInsets.only(right: 100.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: StreamBuilder<bool>(
              builder: (context, snapshot) {
                return SizedBox(
                  height: 40,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.indigo[700],
                      padding: const EdgeInsets.all(16.0),
                    ),
                    onPressed: _submit,
                    child: Text("Save"),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );

    var l = new List<Widget>();
    l.add(form);

    if (_saving) {
      var modal = new Stack(
        children: [
          new Opacity(
            opacity: 0.3,
            child: const ModalBarrier(dismissible: false, color: Colors.grey),
          ),
          new Center(
            child: new CircularProgressIndicator(),
          ),
        ],
      );
      l.add(modal);
    }

    return l;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: const Text('Move-Aqua'),
      ),
      body: new Stack(
        children: _buildForm(context),
      ),
    );
  }
}

// Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (contexto) => FormTanque()),
//                   );


//  new CheckboxListTile(
//             title: const Text('Sensor de temperatura?'),
//             value: _temp,
//             onChanged: (bool value) {
//               setState(() {
//                 _temp = value;
//               });
//             },
//             secondary: const Icon(Icons.wb_sunny),
//           ),
//           new TextFormField(
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               icon: Icon(Icons.format_list_numbered_rtl),
//               hintText: 'Número do sensor',
//               contentPadding: const EdgeInsets.only(
//                 right: 100.0),
//             ),

//           ),
//           new CheckboxListTile(
//             title: const Text('Sensor de oxigênio?'),
//             value: _oxi,
//             onChanged: (bool value) {
//               setState(() {
//                 _oxi = value;
//               });
//             },
//             secondary: const Icon(Icons.graphic_eq),
//           ),
