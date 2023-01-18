import 'package:aquicultura_transporte/tabs/charts_tab.dart';
import 'package:aquicultura_transporte/telas/Form_tanque_tela.dart';
import 'package:aquicultura_transporte/widgets/AppBar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../telas/Form_tanque_tela.dart';
import '../validators/firebase_validators.dart';

//dados
//lista
//materia

int tanque = 2;
double oxi = 12.5, temp = 23.2;

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  var spacecrafts = [
    "Tanque " + tanque.toString(),
  ];

  int cont = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar.getAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (contexto) => FormTanque()),
          );
        },
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.indigo,
      ),
      body: Container(
        width: 168,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Colors.green,
          elevation: 15,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: FlatButton(
                  child: Row(
                    children: <Widget>[
                      Icon(
                        Icons.sentiment_satisfied,
                        size: 45,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 4),
                      ),
                      Text(
                        'Tanque $tanque',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ],
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (contexto) => ChartTab()),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 10),
                child: ButtonBar(
                  children: <Widget>[
                    new Text('Temperatura: $temp °C',
                        style: new TextStyle(
                          color: Colors.white,
                          fontFamily: 'Roboto',
                        )),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.only(right: 22),
                child: ButtonBar(
                  children: <Widget>[
                    new Text(
                      'Oxigênio: $oxi mg/l',
                      style: new TextStyle(
                        color: Colors.white,
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: new ButtonBar(
                  children: <Widget>[
                    FlatButton(
                      textColor: Colors.white,
                      child: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (contexto) => FormTanque()),
                        );
                      },
                    ),
                    FlatButton(
                      textColor: Colors.white,
                      child: Icon(Icons.delete),
                      onPressed: () {
                        deleteTanque(1);
                      },
                    ),
                  ],
                ),
              ),

//                                       RaisedButton(
//   child: Text('Create Tanque'),
//   onPressed: () {
//     createTanque(6, 31, 13);
//     cont++;
//   },
// ),
// RaisedButton(
//   child: Text('Ver Tanque'),
//   onPressed: () {
//     getTanque(2);
//   },
// ),
// RaisedButton(
//   child: Text('Envia dados do Tanque'),
//   onPressed: () {
//     updateData(4);
//   },
// ),
// RaisedButton(
//   child: Text('Delete o Tanque ' + cont.toString()),
//   onPressed: () {
//     deleteTanque(cont);
//     cont <= 0 ? cont = 1 : cont--;
//     print(cont);

//     //getAllData();
//   },
// ),
            ],
          ),
        ),
        // new Card(
        //   elevation: 5.0,
        //   child: new Container(
        //     alignment: Alignment.centerLeft,
        //     margin: new EdgeInsets.only(top: 10.0, bottom: 10.0,left: 10.0),
        //     child: new Text(spacecrafts[index]),
        //   ),
        // ),
      ),
    );
  }
}

// StaggeredGridView.count(
//           crossAxisCount: 4,
//           crossAxisSpacing: 12.0,
//           mainAxisSpacing: 12.0,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.all(7.0),
//               child: mychart1Items("Temperatura"),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(7.0),
//             child: mychart2Items("Oxigênio"),
//             ),
//           ],
//           staggeredTiles: [
//             StaggeredTile.extent(4, 220.0),
//             StaggeredTile.extent(4, 220.0),
//           ],
//         ),
//  ),

//Grid

// Column(
//                   children: <Widget>[
//                   ButtonBar(
//                     children: <Widget>[
//                       new Text('Temp: $_temp °C',
//                           style: new TextStyle(
//                             color: Colors.white,
//                             fontFamily: 'Roboto',
//                           )),
//                     ],
//                   ),]
//                 ),
//                 Column(
//                   children: <Widget>[
//                   ButtonBar(
//                     children: <Widget>[
//                   new Text('Oxigênio: $_oxi mg/l',
//                         style: new TextStyle(
//                           color: Colors.white,
//                           fontFamily: 'Roboto',
//                         ),
//                       ),
//                         ],
//                   ),]
//                 ),
