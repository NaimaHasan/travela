import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';


class DestinationCarousel extends StatelessWidget {
  const DestinationCarousel({Key? key, required this.controller, required this.imgList}) : super(key: key);

  final CarouselController controller;
  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(5.0), bottomLeft: Radius.circular(5.0)),
      child: CarouselSlider(
        carouselController: controller,
        options: CarouselOptions(
          autoPlay: false,
          viewportFraction: 1,
          height: 0.6 * screenSize.height,
          initialPage: 5,

        ),
        items: imgList
            .map(
              (item) => Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: item,
                      fit: BoxFit.cover,
                      height: 0.6 * screenSize.height,
                    ),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
