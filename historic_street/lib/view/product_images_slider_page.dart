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
      indicatorColor: const Color.fromARGB(255, 254, 165, 0),
      indicatorBackgroundColor: Colors.white,
      height: 500,
      autoPlayInterval: 1000,
      indicatorRadius: 4,
      isLoop: false,
      children: [
        Padding(
          padding: const EdgeInsets.all(8),
          child: Image.network(img),
        ),
      ],
    );
  }
}
