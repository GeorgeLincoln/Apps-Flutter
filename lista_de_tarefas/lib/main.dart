import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main(List<String> args) {
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
  final _toDoController = TextEditingController();

  //lista para armazenar as tarefas
  List _toDoList = [];
  Map<String, dynamic> _lastRemoved;
  int _lastRemovedPos;

  //para ler os dados do arquivo
  @override
  void initState() {
    super.initState();

    //assim que terminar de obter os dados
    //vai passar a String de retorno da _readData()
    _readData().then((data) {
      setState(() {
        _toDoList = json.decode(data);
      });
    });
  }

  //Armazenar o retorno do texto escrito do usuário
  //na nova tarefa = newToDo
  void _addToDo() {
    //quando for adicionado um novo item na lista
    //o setState vai atualizar a tela
    setState(() {
      Map<String, dynamic> newToDo = Map();
      newToDo["title"] = _toDoController.text;
      //resetar o texto
      _toDoController.text = "";
      //tarefa não concluida
      newToDo["ok"] = false;
      _toDoList.add(newToDo);

      _saveData();
    });
  }

  //delay de um segundo
  //para esperar a organização das tarefas
  // função
  Future<Null> _refresh() async {
    await Future.delayed(Duration(seconds: 1));
    //ordenar a lista
    setState(() {
      _toDoList.sort((a, b) {
        if (a["ok"] && !b["ok"])
          return 1;
        else if (!a["ok"] && b["ok"])
          return -1;
        else
          return 0;
      });

      _saveData();
    });

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.blueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(17, 1, 7, 1),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _toDoController,
                    decoration: InputDecoration(
                        labelText: "Nova Tarefa",
                        labelStyle: TextStyle(color: Colors.blueAccent)),
                  ),
                ),
                RaisedButton(
                  color: Colors.blueAccent,
                  child: Text("Add"),
                  textColor: Colors.white,
                  onPressed: _addToDo,
                ),
              ],
            ),
          ),
          Expanded(
              child: RefreshIndicator(
            onRefresh: _refresh,
            child: ListView.builder(
                padding: EdgeInsets.only(top: 10),
                itemCount: _toDoList.length, //tamanho da lista
                itemBuilder: buildItem),
          )),
        ],
      ),
    );
  }

  Widget buildItem(context, index) {
    //Dismissible permite arrasta o item para deletar
    return Dismissible(
      // Só para o Dismissible saber quem vai deletar depois
      // Tô setando o tempo atual em milissegundos
      // Poderia ser um randomString()
      key: Key(DateTime.now().millisecondsSinceEpoch.toString()),
      background: Container(
        color: Colors.red,
        child: Align(
          // alinha o icon no canto esquerdo
          alignment: Alignment(-0.9, 0), //-0,9 == 90% para esquerda
          child: Icon(
            Icons.delete,
            color: Colors.white,
          ),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        title: Text(_toDoList[index]["title"]),
        value: _toDoList[index]["ok"],
        secondary: CircleAvatar(
          child: Icon(_toDoList[index]["ok"] ? Icons.check : Icons.error),
        ),
        onChanged: (c) {
          setState(() {
            _toDoList[index]["ok"] = c;
            _saveData();
          });
        },
      ),
      //função para deletar o item da lista
      // ao mover o item para direita
      onDismissed: (directon) {
        setState(() {
          _lastRemoved = Map.from(_toDoList[index]);
          _lastRemovedPos = index;
          _toDoList.removeAt(index);

          _saveData();

          final snack = SnackBar(
            content: Text("Tarefa \"${_lastRemoved["title"]}\" foi removida!"),
            action: SnackBarAction(
                label: "Desfazer",
                onPressed: () {
                  setState(() {
                    _toDoList.insert(_lastRemovedPos, _lastRemoved);
                    _saveData();
                  });
                }),
            duration: Duration(seconds: 2),
          );
          //para remover o snack
          Scaffold.of(context).removeCurrentSnackBar();
          //para mostrar o snack
          Scaffold.of(context).showSnackBar(snack);
        });
      },
    );
  }

  //funcão para retornar o arquivo para salvar
  Future<File> _getFile() async {
    //diretório para armazenar os documentos
    final directory = await getApplicationDocumentsDirectory();
    //caminho para o diretório
    return File("${directory.path}/data.json");
  }

  //função para salvar os dados
  Future<File> _saveData() async {
    String data = json.encode(_toDoList);

    final file = await _getFile();
    return file.writeAsString(data);
  }

  //função para obter os dados
  Future<String> _readData() async {
    try {
      //tentando pegar o arquivo
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }
}
