import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class DestinationCarouselMobile extends StatelessWidget {
  //Constructor
  const DestinationCarouselMobile(
      {Key? key, required this.controller, required this.imgList})
      : super(key: key);

  final CarouselController controller;
  final List<String> imgList;

  @override
  Widget build(BuildContext context) {
    //Variable for screen size
    var screenSize = MediaQuery.of(context).size;
    //Displays the carousel slider for desktop
    return CarouselSlider(
      carouselController: controller,
      options: CarouselOptions(
        autoPlay: false,
        viewportFraction: 1,
        height: 0.4 * screenSize.height,
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
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }
}
