import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:travela/common/models/destination.dart';
import 'package:travela/screens/destination/widgets/destination_carousel_mobile.dart';

import '../../../widgets/common/pill_button.dart';
import '../../../widgets/common/spacing.dart';
import '../../new_trip/new_trip_screen.dart';

//A stateless widget for destination widget mobile
class DestinationImageMobile extends StatelessWidget {
  //Constructor
  const DestinationImageMobile({Key? key, required this.destination})
      : super(key: key);

  final Destination destination;

  @override
  Widget build(BuildContext context) {
    //Variable for screen size
    var screenSize = MediaQuery.of(context).size;
    //Carousel controller
    CarouselController buttonCarouselController = CarouselController();

    return Stack(
      alignment: Alignment.center,
      children: [
        //Widget for destination image
        //Calls DestinationCarouselMobile
        Column(
          children: [
            DestinationCarouselMobile(
              imgList: destination.image,
              controller: buttonCarouselController,
            ),
            const SizedBox(height: 35),
          ],
        ),
        //Card for destination name, tag and plan a trip button
        Positioned(
          bottom: 0,
          child: Card(
            elevation: 10,
            child: SizedBox(
              width: 400,
              height: 80,
              child: Row(
                children: [
                  horizontalSpaceSmall,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Displays destination tag
                      Text(
                        destination.tag,
                        style: const TextStyle(fontSize: 14),
                      ),
                      //Displays destination name
                      SizedBox(
                        width: 200,
                        child: Text(
                          destination.name,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  //Pill button for plan a trip
                  PillButton(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    onPress: () {
                      Navigator.of(context).pushNamed(NewTripScreen.routeName,
                          arguments: [destination.name, destination.address]);
                    },
                    child: const Text(
                      "Plan a trip now",
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                  horizontalSpaceSmall,
                ],
              ),
            ),
          ),
        ),
        //Displays forward carousel arrow
        Positioned(
          bottom: 0.21 * screenSize.height,
          right: 5,
          child: IconButton(
            onPressed: () {
              buttonCarouselController.nextPage();
            },
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            color: Colors.white,
            iconSize: 24,
          ),
        ),
        //Displays backward carousel arrow
        Positioned(
          bottom: 0.21 * screenSize.height,
          left: 5,
          child: IconButton(
            onPressed: () {
              buttonCarouselController.previousPage();
            },
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
            iconSize: 24,
          ),
        ),
      ],
    );
  }
}
