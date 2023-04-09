import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:historic_street/model/doodle.dart';
import 'package:historic_street/view/item_page.dart';
import 'package:historic_street/view/product_images_slider_page.dart';
import 'package:timelines/timelines.dart';

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  final databaseReference = FirebaseDatabase.instance.ref;

  List<Doodle> doodleData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    CollectionReference<Map<String, dynamic>> collection =
        FirebaseFirestore.instance.collection('doodle');
    QuerySnapshot<Map<String, dynamic>> querySnapshot = await collection.get();
    for (var queryDocumentSnapshot in querySnapshot.docs) {
      Map<String, dynamic> data = queryDocumentSnapshot.data();
      Doodle model = Doodle.fromMap(data);
      doodleData.add(model);
      doodleData.sort((a, b) => a.id.compareTo(b.id));
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 254, 165, 0),
      body: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Timeline.tileBuilder(
                  theme: TimelineThemeData(
                    color: const Color.fromARGB(255, 0, 81, 140),
                    connectorTheme: const ConnectorThemeData(
                      color: Colors.white,
                    ),
                  ),
                  builder: TimelineTileBuilder.fromStyle(
                    contentsAlign: ContentsAlign.alternating,
                    contentsBuilder: (context, index) {
                      return Card(
                        margin: const EdgeInsets.all(10),
                        elevation: 10,
                        child: TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.black,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Image.asset(
                                        'images/${doodleData[index].image}/image2.jpg')),
                                Expanded(
                                  child: SingleChildScrollView(
                                    scrollDirection: Axis.vertical,
                                    child: Text(
                                      textAlign: TextAlign.center,
                                      doodleData[index].name,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ItemPage(
                                img: doodleData[index].image,
                                name: doodleData[index].name,
                                history: doodleData[index].content,
                                local: doodleData[index].local,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: doodleData.length,
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
