import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
      //para suportar widget do material designer
      debugShowCheckedModeBanner: false,
      title: "Contador de Pessoas", // parametros opcionais
      home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _infoText = "Pode Entrar";
  int _pessoas  = 0;
  void _changePeople(int delta){
    
    setState(() {
      _pessoas+= delta;
       if(_pessoas < 0)
       _infoText = "Mundo Invertido?";
       else if(_pessoas <= 10)
        _infoText = "Pode Entrar";
      else _infoText = "Lotado"; 
    });
    
  }
  
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      Image.asset(
        "images/original.jpg",
        fit: BoxFit.cover,
        height: 1000.0,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Pessoas: $_pessoas",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextButton(
                  child: Text(
                    "+1",
                    style: TextStyle(fontSize: 40.0, color: Colors.white),
                  ),
                  onPressed: () {
                    _changePeople(1);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: TextButton(
                    child: Text(
                      "-1",
                      style: TextStyle(fontSize: 40.0, color: Colors.white),
                    ),
                    onPressed: () {
                     _changePeople(-1);
                    }), //funcão anônima
              ),
            ],
          ),
          Text(_infoText,
              style: TextStyle(
                  color: Colors.white,
                  fontStyle: FontStyle.italic,
                  fontSize: 30.0)),
        ],
      )
    ]);
  }
}
