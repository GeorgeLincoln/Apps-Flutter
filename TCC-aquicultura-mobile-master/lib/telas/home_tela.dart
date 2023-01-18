import 'package:aquicultura_transporte/tabs/charts_tab.dart';
import 'package:aquicultura_transporte/telas/Form_Relatorio.dart';
import 'package:aquicultura_transporte/ui/page_addlist.dart';

import 'package:flutter/material.dart';

import 'Cards_tela.dart';
import 'Form_tanque_tela.dart';

//import 'package:charts_flutter/flutter.dart';

class HomeTela extends StatefulWidget {
  @override
  _HomeTelaState createState() => _HomeTelaState();
}

class _HomeTelaState extends State<HomeTela> {

  PageController _pageController;
  int _page = 0;

  @override
  void initState() {
    super.initState();

    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose;

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.indigo,
          primaryColor: Colors.white,
          textTheme: Theme.of(context).textTheme.copyWith(
            caption: TextStyle(color: Colors.white54)
          )
        ),
        child: BottomNavigationBar(
          currentIndex: _page,
          onTap: (p){
            _pageController.animateToPage(
              p,
              duration: Duration(microseconds: 500),
              curve: Curves.ease
            );

          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.insert_chart),
              title: Text("Gráficos")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.map),
              title: Text("Localização")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.announcement),
              title: Text("Relatório")
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              title: Text("Pedidos")
            )
          ]
        ),
      ),
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          onPageChanged: (p){
            setState(() {
              _page = p;
            });
          },
          children: <Widget>[
            Cards(),
            NewTaskPage(),
            Relatorio(),
            FormTanque()
          ],
        ),
      ),
    );
  }

  ChartTab buildChartTab() => ChartTab();
}