import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timeline_list/timeline.dart';
import 'package:timeline_list/timeline_model.dart';
import 'package:historic_street/model/model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: StreamBuilder<List<Data>>(
          stream: readData(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Invalid snapshot');
            } else if (snapshot.hasData) {
              final data = snapshot.data!;

              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(data[index].name),
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );

    // Timeline(
    //   children: <TimelineModel>[
    //     TimelineModel(
    //       const SizedBox(
    //         height: 100,
    //         child: Center(
    //           child: Text("data"),
    //         ),
    //       ),
    //       icon: const Icon(Icons.receipt, color: Colors.white),
    //       iconBackground: Colors.blue,
    //     ),
    //     TimelineModel(
    //       const SizedBox(
    //         height: 100,
    //         child: Center(
    //           child: Text("data"),
    //         ),
    //       ),
    //       icon: const Icon(Icons.android),
    //       iconBackground: Colors.cyan,
    //     ),
    //   ],
    //   position: TimelinePosition.Left,
    //   iconSize: 40,
    //   lineColor: Colors.blue,
    // ); //TimelinePage(title: 'Muslim Civilisation Doodles'),
  }

  Stream<List<Data>> readData() => FirebaseFirestore.instance
      .collection('data')
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((e) => Data.fromJson(e.data())).toList());
}
