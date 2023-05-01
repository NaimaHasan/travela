import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:travela/screens/destination/widgets/destination_carousel.dart';
import 'package:travela/screens/destination/widgets/destination_carousel_control.dart';
import 'package:travela/screens/destination/widgets/destination_carousel_mobile.dart';

import '../../../widgets/common/pill_button.dart';
import '../../../widgets/common/spacing.dart';
import '../../new_trip/new_trip_screen.dart';

class DestinationImageMobile extends StatelessWidget {
  const DestinationImageMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    CarouselController buttonCarouselController = CarouselController();

    return Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            DestinationCarouselMobile(
              controller: buttonCarouselController,
            ),
            SizedBox(height: 35,),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Card(
            elevation: 10,
            child: SizedBox(
              width: 0.55 * screenSize.width,
              height: 60,
              child: Row(
                children: [
                  horizontalSpaceSmall,
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
                          fontSize: 14,
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
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10),
                    onPress: () {
                      Navigator.of(context).pushNamed(NewTripScreen.routeName);
                    },
                  ),
                  horizontalSpaceSmall,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 65,
          child: DestinationCarouselControl(
            controller: buttonCarouselController,
          ),
        ),
      ],
    );
  }
}
