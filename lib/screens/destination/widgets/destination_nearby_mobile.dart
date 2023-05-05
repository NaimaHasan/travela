import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../destination_screen.dart';

final List<Widget> imageSliders = [1, 2, 3, 4, 5]
    .map(
      (item) => Padding(
        padding: const EdgeInsets.all(5),
        child: Card(
          shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: Colors.black54,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(7),
                  child: Image.asset(
                    'lib/assets/dummy.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.only(top: 10, bottom: 15, left: 15, right: 15),
                child: Text(
                  'Hotel X',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(bottom: 5, left: 15, right: 15),
                child: Text(
                  'Address',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 15, bottom: 20),
                child: Text(
                  'kasudhkuaw adskjadkad asdkahsgdka dsggdg',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    )
    .toList();

class DestinationNearbyPlacesMobile extends StatelessWidget {
  const DestinationNearbyPlacesMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: CarouselSlider(
        options: CarouselOptions(
            autoPlay: false,
            aspectRatio: 1.2,
            enlargeCenterPage: true,
            enlargeStrategy: CenterPageEnlargeStrategy.height,
            enlargeFactor: 0.1,
            viewportFraction: 1,
            //height: 355,
            initialPage: 5),
        items: [
          for (var element in imageSliders)
            InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(DestinationScreen.routeName);
              },
              child: element,
            ),
        ],
      ),
    );
  }
}
