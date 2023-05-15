import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travela/screens/destination/widgets/destination_image_mobile.dart';
import 'package:travela/screens/destination/widgets/destination_nearby_mobile.dart';

import '../../common/api/destination_controller.dart';
import '../../common/api/location_controller.dart';
import '../../common/models/destination.dart';
import '../../widgets/common/bottom_bar.dart';
import '../../widgets/common/spacing.dart';
import '../../widgets/common/top_navigation_bar.dart';
import 'package:latlong2/latlong.dart';

//A stateless widget for Destination Screen Mobile
class DestinationScreenMobile extends StatefulWidget {
  //Constructor
  const DestinationScreenMobile({Key? key, required this.destinationName})
      : super(key: key);

  final String destinationName;

  @override
  State<DestinationScreenMobile> createState() =>
      _DestinationScreenMobileState();
}

class _DestinationScreenMobileState extends State<DestinationScreenMobile> {
  late Future<Destination?> _future;
  late Future<LatLng?> _mapFuture;

  @override
  void initState() {
    _future = DestinationController.getDestination(widget.destinationName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Variable for screen size
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        //Calls the top navigation bar widget
        child: const TopNavigationBar(
          hasSearch: false,
        ),
      ),
      //Future builder for destination data
      //Checks the relevant conditions and displays messages on screen accordingly
      body: FutureBuilder(
        future: _future,
        builder: (ctx, futureResult) {
          if (futureResult.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!futureResult.hasData || futureResult.data == null) {
            return const Center(
              child: Text("No destination by that name"),
            );
          }
          _mapFuture = LocationController.getDestinationLocation(
              futureResult.data!.name, futureResult.data!.address);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //Calls the DestinationImageMobile widget for displaying destination image
                DestinationImageMobile(
                  destination: futureResult.data!,
                ),
                const Padding(
                  padding:
                      EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 30),
                  child: Text(
                    'Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                //Displays the destination address
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    futureResult.data!.address,
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                //Displays the description if there is destination description
                if (futureResult.data!.description != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 30),
                        child: Text(
                          'Description',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Text(
                          futureResult.data!.description!,
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                //Displays the location of the destination using flutter map
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 15, top: 30),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Location',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.yellow[700],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width / 2,
                  child: FutureBuilder(
                    future: _mapFuture,
                    builder: (ctx, futureResult) {
                      if (futureResult.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (!futureResult.hasData || futureResult.data == null) {
                        return FlutterMap(
                          options: MapOptions(),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName:
                                  'dev.fleaflet.flutter_map.example',
                            ),
                          ],
                        );
                      }
                      return FlutterMap(
                        options: MapOptions(
                          center: futureResult.data!,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 150.0,
                                height: 150.0,
                                point: futureResult.data!,
                                builder: (ctx) => const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 35.0,
                                ),
                              ),
                            ],
                          )
                        ],
                      );
                    },
                  ),
                ),
                //Displays Nearby places and shows corresponding message
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, bottom: 10, top: 40),
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          'Nearby Places',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                      Icon(
                        Icons.maps_home_work_outlined,
                        color: Colors.yellow[700],
                      )
                    ],
                  ),
                ),
                //Future builder for nearby places
                FutureBuilder(
                  future: _mapFuture,
                  builder: (ctx, futureResult) {
                    if (futureResult.connectionState ==
                        ConnectionState.waiting) {
                      return const SizedBox(
                        height: 400,
                        child: Center(child: CircularProgressIndicator()),
                      );
                    }
                    if (!futureResult.hasData || futureResult.data == null) {
                      return const SizedBox(
                        height: 400,
                        child: Center(
                            child: Text("Unable to fetch nearby destinations")),
                      );
                    }
                    return DestinationNearbyPlacesMobile(
                        location: futureResult.data!);
                  },
                ),
                verticalSpaceMedium,
                const BottomBar(),
              ],
            ),
          );
        },
      ),
    );
  }
}
