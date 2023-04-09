import 'package:flutter/material.dart';
import 'package:historic_street/view/product_images_slider_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:wikipedia/wikipedia.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ItemPage extends StatefulWidget {
  final String img;
  final String name;
  final String history;
  final String local;
  const ItemPage({
    super.key,
    required this.img,
    required this.name,
    required this.history,
    required this.local,
  });

  @override
  State<ItemPage> createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height / 2.2,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 254, 165, 0),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  )),
              child: Stack(
                children: [
                  Center(
                    child: ProductImagesSliderPage(img: widget.img),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15, top: 20),
                    child: InkWell(
                      onTap: () => Navigator.pop(context),
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        size: 25,
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.vertical,
                              child: Text(
                                widget.name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => _openMaps(widget.local),
                            icon: const Icon(
                              Icons.location_on_outlined,
                              color: Color.fromARGB(255, 11, 126, 15),
                            ),
                          ),
                        ],
                      ),
                      Text(widget.history),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _openMaps(local) async {
    String urlMap = "https://www.google.com/maps/search/?api=1&query=$local";
    if (await canLaunchUrlString(urlMap)) {
      await launchUrlString(urlMap);
    } else {
      throw 'Could not launch Maps';
    }
  }
}
