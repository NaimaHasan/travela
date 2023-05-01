import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';

class DestinationCarouselControl extends StatefulWidget {
  const DestinationCarouselControl({Key? key, required this.controller}) : super(key: key);

  final CarouselController controller;

  @override
  State<DestinationCarouselControl> createState() =>
      _DestinationCarouselControlState();
}

class _DestinationCarouselControlState
    extends State<DestinationCarouselControl> {
  int totalPages = 6;
  int currentPage = 5;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: totalPages,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.all(5),
            child: InkWell(
              child: CircleAvatar(
                radius: index == currentPage ? 7 : 5,
                foregroundColor: index == currentPage ? Colors.white:Colors.white70,
                backgroundColor: index == currentPage ? Color.fromARGB(200, 255, 255, 255):Colors.white70,
              ),
              onTap: (){
                widget.controller.animateToPage(index);
                setState(() {
                  currentPage = index;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
