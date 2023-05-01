import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:travela/screens/destination/widgets/destination_carousel.dart';
import 'package:travela/screens/destination/widgets/destination_carousel_control.dart';

import '../../../widgets/common/pill_button.dart';
import '../../../widgets/common/spacing.dart';
import '../../new_trip/new_trip_screen.dart';

class DestinationImage extends StatelessWidget {
  const DestinationImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    CarouselController buttonCarouselController = CarouselController();

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
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
            SizedBox(
              height: 30,
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Card(
            elevation: 10,
            child: SizedBox(
              width: 0.35 * screenSize.width,
              height: 100,
              child: Row(
                children: [
                  horizontalSpaceMedium,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Destination",
                        style: TextStyle(
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        "Honolulu",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  PillButton(
                    child: Text(
                      "Plan a trip now",
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    onPress: () {
                      Navigator.of(context).pushNamed(NewTripScreen.routeName);
                    },
                  ),
                  horizontalSpaceMedium,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          child: DestinationCarouselControl(
            controller: buttonCarouselController,
          ),
        ),
      ],
    );
  }
}
