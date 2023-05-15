import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:travela/screens/destination/widgets/destination_carousel.dart';

import '../../../common/models/destination.dart';
import '../../../widgets/common/pill_button.dart';
import '../../../widgets/common/spacing.dart';
import '../../new_trip/new_trip_screen.dart';

class DestinationImage extends StatelessWidget {
  const DestinationImage({Key? key, required this.destination})
      : super(key: key);

  final Destination destination;

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
                      imgList: destination.image,
                      controller: buttonCarouselController,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 50),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Card(
            elevation: 10,
            child: SizedBox(
              width: 500,
              height: 100,
              child: Row(
                children: [
                  horizontalSpaceMedium,
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.tag,
                        style: const TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 250,
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
                  PillButton(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                    onPress: () {
                      Navigator.of(context).pushNamed(NewTripScreen.routeName,
                          arguments: destination.name);
                    },
                    child: const Text(
                      "Plan a trip now",
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  ),
                  horizontalSpaceMedium,
                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0.3 * screenSize.height,
          right: 10,
          child: IconButton(
            onPressed: () {
              buttonCarouselController.nextPage();
            },
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_forward_ios_outlined),
            color: Colors.white,
            iconSize: 35,
          ),
        ),
        Positioned(
          bottom: 0.3 * screenSize.height,
          left: 100,
          child: IconButton(
            onPressed: () {
              buttonCarouselController.previousPage();
            },
            visualDensity: VisualDensity.compact,
            padding: EdgeInsets.zero,
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
            iconSize: 35,
          ),
        ),
      ],
    );
  }
}
