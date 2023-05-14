import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:travela/common/api/destinationController.dart';

import '../destination_screen.dart';
import 'package:latlong2/latlong.dart';

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

class DestinationNearbyPlaces extends StatelessWidget {
  const DestinationNearbyPlaces({Key? key, required this.location})
      : super(key: key);

  final LatLng location;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DestinationController.getNearbyPlaces(
          location.latitude, location.longitude),
      builder: (ctx, futureResult) {
        if (futureResult.connectionState ==
            ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        if (!futureResult.hasData || futureResult.data == null) {
          return Center(child: Text("Unable to fetch nearby destinations"));
        }
        return ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: CarouselSlider(
            options: CarouselOptions(
              autoPlay: false,
              aspectRatio: 4,
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
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(7),
                              child: Image.network(
                                destination.image[0],
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                            EdgeInsets.only(top: 10, bottom: 15, left: 15, right: 15),
                            child: Text(
                              destination.name,
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(bottom: 5, left: 15, right: 15),
                            child: Text(
                              destination.address,
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          SizedBox(height: 20),
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
