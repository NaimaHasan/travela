import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class DestinationCarouselControl extends StatefulWidget {
  const DestinationCarouselControl({Key? key, required this.controller})
      : super(key: key);

  final CarouselController controller;

  @override
  State<DestinationCarouselControl> createState() =>
      _DestinationCarouselControlState();
}

class _DestinationCarouselControlState
    extends State<DestinationCarouselControl> {
  int totalPages = 6;
  int index = 1;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(
          () {
            index = index + 1;
            if (index > totalPages) {
              index = 1;
            }
          },
        );
        widget.controller.animateToPage(index);
      },
      icon: Icon(Icons.arrow_forward_ios_outlined),
      color: Colors.white,
      iconSize: 30,
    );
  }
}
