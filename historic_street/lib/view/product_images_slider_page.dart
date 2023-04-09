// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';

class ProductImagesSliderPage extends StatelessWidget {
  final String img;

  const ProductImagesSliderPage({
    Key? key,
    required this.img,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ImageSlideshow(
      indicatorColor: const Color.fromARGB(255, 0, 81, 140),
      indicatorBackgroundColor: Colors.white,
      height: 500,
      autoPlayInterval: 2000,
      indicatorRadius: 6,
      initialPage: 5,
      isLoop: true,
      children: [
        for (int i = 2; i < 5; i++) numImage(i),
      ],
    );
  }

  Widget numImage(index) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Image.asset(
        'images/$img/image$index.jpg',
      ),
    );
  }
}
