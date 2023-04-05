import 'package:flutter/material.dart';
import 'package:historic_street/view/product_images_slider_page.dart';

class ItemPage extends StatelessWidget {
  final String img;
  final String name;
  const ItemPage({
    super.key,
    required this.img,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              width: MediaQuery.of(context).size.width,
              // decoration: const BoxDecoration(
              //     color: Color(0xFFD4ECF7),
              //     borderRadius: BorderRadius.only(
              //       bottomLeft: Radius.circular(30),
              //       bottomRight: Radius.circular(30),
              //     )),
              child: Stack(
                children: [
                  Center(
                    child: ProductImagesSliderPage(img: img),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
