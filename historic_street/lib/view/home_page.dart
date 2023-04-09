import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:historic_street/model/doodle.dart';
// import 'package:timeline_list/timeline.dart';
// import 'package:timeline_list/timeline_model.dart';
// import 'package:historic_street/model/doodle.dart';
import 'package:timelines/timelines.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<Doodle> items;

  final CollectionReference _doodles =
      FirebaseFirestore.instance.collection('doodle');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _doodles.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Container();
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
    );
  }
  // Timeline.tileBuilder(
  //   builder: TimelineTileBuilder.fromStyle(
  //     addAutomaticKeepAlives: true,
  //     contentsAlign: ContentsAlign.alternating,
  //     contentsBuilder: (context, index) =>
  //     Column(
  //       children: [
  //         const Icon(Icons.abc),
  //         Padding(
  //           padding: const EdgeInsets.all(24.0),
  //           child: Text('Timeline Event $index'),
  //         ),
  //       ],
  //     ),
  //     itemCount: 10,
  //   ),
  // ),
  //TimelinePage(title: 'Muslim Civilisation Doodles'),
}

//   Scaffold(
//     // Using StreamBuilder to display all products from Firestore in real-time
//     body: StreamBuilder(
//       stream: _doodles.snapshots(),
//       builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
//         if (streamSnapshot.hasData) {
//           return ListView.builder(
//             itemCount: streamSnapshot.data!.docs.length,
//             itemBuilder: (context, index) {
//               final DocumentSnapshot documentSnapshot =
//                   streamSnapshot.data!.docs[index];
//               String name = documentSnapshot['name'];
//               String content = documentSnapshot['content'];
//               return
//               ListTile(
//                 title: Text(name),
//                 subtitle: Text(content),

//               );
//             },
//           );
//         }

//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       },
//     ),
//     // Add new product
//     floatingActionButton: FloatingActionButton(
//       onPressed: () => _createOrUpdate(),
//       child: const Icon(Icons.add),
//     ),
//   );
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     String doodle = '';
//     return Timeline(
//       children: <TimelineModel>[
//         TimelineModel(
//           SizedBox(
//             height: 100,
//             child: StreamBuilder<List<Doodle>>(
//                 stream: readData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.hasError) {
//                     return const Text('Invalid snapshot');
//                   } else if (snapshot.hasData) {
//                     final data = snapshot.data!;
//                     return Center(
//                       child: ListView.builder(
//                           itemCount: data.length,
//                           itemBuilder: (context, index) {
//                             return ListTile(
//                               title: Text(data[index].name),
//                               iconColor: Colors.amber,
//                               textColor: Colors.red,

//                             );
//                           }),
//                     );
//                   } else {
//                     return const Center(
//                       child: CircularProgressIndicator(),
//                     );
//                   }
//                 }),
//           ),
//           icon: const Icon(Icons.receipt, color: Colors.white),
//           iconBackground: Colors.blue,
//         ),
//         TimelineModel(
//           SizedBox(
//             height: 100,
//             child: Center(
//               child: Text(doodle),
//             ),
//           ),
//           icon: const Icon(Icons.android),
//           iconBackground: Colors.cyan,
//         ),
//       ],
//       position: TimelinePosition.Left,
//       iconSize: 40,
//       lineColor: Colors.blue,
//     ); //TimelinePage(title: 'Muslim Civilisation Doodles'),
//   }

//   Stream<List<Doodle>> readData() => FirebaseFirestore.instance
//       .collection('doodle')
//       .snapshots()
//       .map((snapshot) =>
//           snapshot.docs.map((e) => Doodle.fromJson(e.data())).toList());
// }
class ListDoodle extends StatefulWidget {
  final Doodle doodle;

  const ListDoodle(this.doodle, {super.key});

  @override
  State<ListDoodle> createState() => _ListDoodleState();
}

class _ListDoodleState extends State<ListDoodle> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Card(
          child: ListTile(
            title: Text(widget.doodle.name),
          ),
        ),
      ],
    );
  }
}
