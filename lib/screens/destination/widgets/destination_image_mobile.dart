import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:travela/screens/destination/widgets/destination_carousel.dart';
import 'package:travela/screens/destination/widgets/destination_carousel_control.dart';
import 'package:travela/screens/destination/widgets/destination_carousel_mobile.dart';

import '../../../widgets/common/spacing.dart';

class DestinationImageMobile extends StatelessWidget {
  const DestinationImageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    CarouselController buttonCarouselController = CarouselController();

    return Stack(
      alignment: Alignment.center,
      children: [
        DestinationCarouselMobile(
          controller: buttonCarouselController,
        ),
        Positioned(
          bottom: 10,
          right: marginHorizontalMobile,
          child: Text(
            "Honolulu",
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: DestinationCarouselControl(controller: buttonCarouselController,),
        ),
      ],
    );
  }
}
