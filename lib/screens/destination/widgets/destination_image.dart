import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:travela/screens/destination/widgets/destination_carousel.dart';
import 'package:travela/screens/destination/widgets/destination_carousel_control.dart';

import '../../../widgets/common/spacing.dart';

class DestinationImage extends StatelessWidget {
  const DestinationImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    CarouselController buttonCarouselController = CarouselController();

    return Stack(
      alignment: Alignment.center,
      children: [
        Row(
          children: [
            horizontalSpaceMargin,
            Expanded(
              child: SizedBox(
                height: 0.6 * screenSize.height,
                child: DestinationCarousel(
                  controller: buttonCarouselController,
                ),
              ),
            ),
          ],
        ),
        Positioned(
          bottom: 30,
          right: marginHorizontal,
          child: Text(
            "Honolulu",
            style: TextStyle(
              color: Colors.white,
              fontSize: 36,
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
