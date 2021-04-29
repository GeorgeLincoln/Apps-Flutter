//http://usuário:senha@host_ou_IP:porta/mjpegstream.cgi?camera=número_da_câmera
//http://outkeyapp:fb05a350-65dc-48e8-9986-0e03b82dc6cf@htexnet.hiseg.net.br:92/mjpegstream.cgi?camera=1

import 'dart:convert';
import 'package:buscador_gifs/ui/gif_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:share/share.dart';
import 'package:transparent_image/transparent_image.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

var _search;
int _ofset = 0;
var url_title =
    'https://developers.giphy.com/branch/master/static/header-logo-8974b8ae658f704a5b48a2d039b8ad93.gif';

class _HomePageState extends State<HomePage> {
  Future<Map> _getGifs() async {
    http.Response response;
    response = _search == null || _search.isEmpty
        ? await http.get(
            'https://api.giphy.com/v1/gifs/trending?api_key=12YU9CEaVJpVVSQpMNpDgaaEUWk362ce&limit=20&rating=g')
        : await http.get(
            'https://api.giphy.com/v1/gifs/search?api_key=12YU9CEaVJpVVSQpMNpDgaaEUWk362ce&q=$_search&limit=19&offset=$_ofset&rating=g&lang=pt');
    return json.decode(response.body);
  }

  @override
  void initState() {
    super.initState();
    _getGifs().then((map) {
      print(map);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Image.network(url_title),
        centerTitle: true,
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              decoration: InputDecoration(
                  labelText: "Pesquise aqui",
                  labelStyle: TextStyle(color: Colors.white),
                  border: OutlineInputBorder()),
              style: TextStyle(color: Colors.white, fontSize: 18),
              textAlign: TextAlign.center,
              onSubmitted: (text) {
                setState(() {
                  _search = text;
                  _ofset = 0;
                });
              },
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: _getGifs(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:
                        return Container(
                          alignment: Alignment.center,
                          child: CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        );
                      default:
                        return snapshot.hasError
                            ? Container(
                                child: Text("DEU ERRO"),
                              )
                            : _createGifTable(context, snapshot);
                    }
                  })),
        ],
      ),
    );
  }

  int _getCount(data) {
    return _search == null || _search.isEmpty ? data.length : data.length + 1;
  }

  Widget _createGifTable(context, snapshot) {
    return GridView.builder(
        padding: EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        itemCount: _getCount(snapshot.data["data"]),
        itemBuilder: (context, index) {
          if (_search == null || index < snapshot.data["data"].length)
            return GestureDetector(
              child: FadeInImage.memoryNetwork(
                  placeholder: kTransparentImage,
                  image: snapshot.data["data"][index]["images"]["fixed_height"]
                      ["url"],
                  height: 300,
                  fit: BoxFit.cover),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            GifPage(snapshot.data["data"][index])));
              },
              onLongPress: () {
                Share.share(snapshot.data["data"][index]["images"]
                    ["fixed_height"]["url"]);
              },
            );
          else
            return Container(
                child: GestureDetector(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 50,
                  ),
                  Text("Carregar mais ...",
                      style: TextStyle(color: Colors.white, fontSize: 22)),
                ],
              ),
              onTap: () {
                setState(() {
                  _ofset += 19;
                });
              },
            ));
        });
  }
}
