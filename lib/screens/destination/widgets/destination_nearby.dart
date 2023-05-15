import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travela/common/api/destinationController.dart';

import '../destination_screen.dart';
import 'package:latlong2/latlong.dart';

//A stateless widget for displaying nearby places for desktop
class DestinationNearbyPlaces extends StatelessWidget {
  //Constructor
  const DestinationNearbyPlaces({Key? key, required this.location})
      : super(key: key);

  final LatLng location;

  @override
  Widget build(BuildContext context) {
    //A future builder for getting nearby places
    //Checks the relevant conditions and displays messages on screen accordingly
    return FutureBuilder(
      future: DestinationController.getNearbyPlaces(
          location.latitude, location.longitude),
      builder: (ctx, futureResult) {
        if (futureResult.connectionState ==
            ConnectionState.waiting) {
          return const SizedBox(
            height: 450,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (!futureResult.hasData || futureResult.data == null) {
          return const SizedBox(
            height: 450,
            child: Center(
                child: Text("Unable to fetch nearby destinations")),
          );
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              height: 450,
              enlargeCenterPage: true,
              enlargeStrategy: CenterPageEnlargeStrategy.height,
              enlargeFactor: 0.1,
              viewportFraction: 0.335,
            ),
            items: [
              for (var destination in futureResult.data!)
                InkWell(
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(DestinationScreen.routeName);
                  },
                  //Widget for displaying the nearby places cards
                  child: Padding(
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
                          //Displays the image of the nearby place
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: CachedNetworkImage(
                                imageUrl: destination.image[0],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          //Displays the name of the nearby place
                          Padding(
                            padding:
                            const EdgeInsets.only(top: 10, bottom: 15, left: 15, right: 15),
                            child: Text(
                              destination.name,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ),
                          //Displays the address of the nearby place
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5, left: 15, right: 15),
                            child: Text(
                              destination.address,
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
