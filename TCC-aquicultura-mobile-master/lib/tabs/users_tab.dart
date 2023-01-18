import 'package:flutter/material.dart';

class UsersTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Pesquisar",
              hintStyle: TextStyle(color: Colors.white),
              icon: Icon(Icons.search, color: Colors.white,),
              border: InputBorder.none
            ),
          ),
        ),
        Expanded(
          child:  ListView.separated(
            itemBuilder: (context, index){
              return ListTile(title: Text("teste $index"),);
            },
            separatorBuilder: (context, index){
              return Divider();
            },
            itemCount: 5,
          ),
        )
      ],
    );
  }
}