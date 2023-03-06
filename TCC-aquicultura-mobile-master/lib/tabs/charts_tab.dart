import 'package:aquicultura_transporte/tabs/MainPage.dart';
import 'package:aquicultura_transporte/widgets/AppBar.dart';

import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_circular_chart/flutter_circular_chart.dart';

//dados
//lista
//materia
class ChartTab extends StatelessWidget {
  var data = [0.0, 1.0, 1.5, 2.0, 0.0, 0.0, -0.5, -1.0, -0.5, 0.0, 0.0];
  var data1 = [0.0, -2.0, 3.5, -2.0, 0.5, 0.7, 0.8, 1.0, 2.0, 3.0, 3.2];

  // List<String> widgetList = ['Tanque 1', 'Tanque 2', 'Tanque 3', 'Tanque 4', 'Tanque 5', 'Tanque 6','Tanque 7', 'Tanque 8', 'Tanque 9', 'Tanque 10', 'Tanque 11', 'Tanque 12'];

  List<CircularStackEntry> circularData = <CircularStackEntry>[
    new CircularStackEntry(
      <CircularSegmentEntry>[
        new CircularSegmentEntry(700.0, Color(0xff4285F4), rankKey: 'Q1'),
        new CircularSegmentEntry(1000.0, Color(0xff40b24b), rankKey: 'Q4'),
      ],
      rankKey: 'Charts',
    ),
  ];

  Material myTextItems(String title) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

//grafico temperatura
  Material mychart1Items(String title) {
    //, String priceVal,String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(1.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: new Sparkline(
                      data: data,
                      lineColor: Color(0xffff6101),
                      pointsMode: PointsMode.all,
                      pointSize: 8.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///grafico oxigenio
  Material mychart2Items(String title) {
    //, String priceVal,String subtitle) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      borderRadius: BorderRadius.circular(24.0),
      shadowColor: Color(0x802196F3),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: new Sparkline(
                      data: data1,
                      fillMode: FillMode.below,
                      fillGradient: new LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.amber[800], Colors.amber[200]],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar.getAppBar(context),
        body: Container(
          color: Colors.blueGrey[100],
          child: StaggeredGridView.count(
            crossAxisCount: 4,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: mychart1Items("Temperatura"),
              ),
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: mychart2Items("Oxigênio"),
              ),
            ],
            staggeredTiles: [
              StaggeredTile.extent(4, 220.0),
              StaggeredTile.extent(4, 220.0),
            ],
          ),
        ));
  }
}


//  Card(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(15.0),
//           ),
//           color: Colors.pink,
//           elevation: 10,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               const ListTile(
//                 leading: Icon(Icons.album, size: 70),
//                 title: Text('Heart Shaker', style: TextStyle(color: Colors.white)),
//                 subtitle: Text('TWICE', style: TextStyle(color: Colors.white)),
//               ),
//               ButtonTheme.bar(
//                 child: ButtonBar(
//                   children: <Widget>[
//                     TextButton(
//                       child: const Text('Edit', style: TextStyle(color: Colors.white)),
//                       onPressed: () {},
//                     ),
//                     TextButton(
//                       child: const Text('Delete', style: TextStyle(color: Colors.white)),
//                       onPressed: () {},
//                     ),
//                   ],
//                 ),
//               ),
//               TextButton(
//                 child: Text('Create Tanque'),
//                 onPressed: () {
//                   createTanque(cont);
//                   cont++;
//                 },
//               ),
//               TextButton(
//                 child: Text('Ver Tanque'),
//                 onPressed: () {
//                   getTanque(2);
//                 },
//               ),
//                TextButton(
//                 child: Text('Envia dados do Tanque'),
//                 onPressed: () {
//                   updateData(4);
//                 },
//               ),
//               TextButton(
//                 child: Text('Delete o Tanque ' + cont.toString()),
//                 onPressed: () {
//                   deleteTanque(cont);
//                   cont--;
//                 },
//               ),
//             ],
//           ),
//         ),




// new GridView.count(
//           crossAxisCount: 3,
//           controller: new ScrollController(keepScrollOffset: false),
//           shrinkWrap: true,
//           scrollDirection: Axis.vertical,
//           children: widgetList.map((String value) {
//             return new Container(
//               height: 250.0,
//               color: Colors.green,
//               margin: new EdgeInsets.all(1.0),
//               child: new Center(
//                 child: new Text(
//                   value,
//                   style: new TextStyle(fontSize: 25.0,color: Colors.white),
//                 ),
//               ),
//             );
//           }).toList(),

