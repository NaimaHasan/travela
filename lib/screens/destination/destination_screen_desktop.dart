import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travela/common/api/destination_controller.dart';
import 'package:travela/common/api/location_controller.dart';
import 'package:travela/screens/destination/widgets/destination_image.dart';
import 'package:travela/screens/destination/widgets/destination_nearby.dart';
import 'package:travela/widgets/common/bottom_bar.dart';

import '../../common/models/destination.dart';
import '../../widgets/common/spacing.dart';
import '../../widgets/common/top_navigation_bar.dart';
import 'package:latlong2/latlong.dart';

//A stateless widget for Destination Screen Desktop
class DestinationScreenDesktop extends StatefulWidget {
  //Constructor
  const DestinationScreenDesktop({
    super.key,
    required this.destinationName,
  });

  final String destinationName;

  @override
  State<DestinationScreenDesktop> createState() =>
      _DestinationScreenDesktopState();
}

class _DestinationScreenDesktopState extends State<DestinationScreenDesktop> {
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
                //Calls the DestinationImage widget for displaying destination image
                DestinationImage(
                  destination: futureResult.data!,
                ),
                verticalSpaceMedium,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Card(
                            elevation: 3,
                            child: Container(
                              width: 0.5 * screenSize.width,
                              padding: const EdgeInsets.only(
                                  top: 20, left: 20, bottom: 20, right: 120),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Address",
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  verticalSpaceSmall,
                                  //Displays the destination address
                                  Text(
                                    futureResult.data!.address,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          //Displays the description if there is destination description
                          verticalSpaceMedium,
                          if (futureResult.data!.description != null)
                            Card(
                              elevation: 3,
                              child: Container(
                                width: 0.5 * screenSize.width,
                                padding: const EdgeInsets.only(
                                    top: 20, left: 20, bottom: 20, right: 120),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Description",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    verticalSpaceSmall,
                                    Text(
                                      futureResult.data!.description!,
                                      style: const TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      //Displays the location of the destination using flutter map
                      Expanded(
                        child: Card(
                          elevation: 3,
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    const Text(
                                      "Location",
                                      style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Expanded(child: Container()),
                                    const Icon(Icons.location_on),
                                  ],
                                ),
                                verticalSpaceSmall,
                                SizedBox(
                                  height: 500,
                                  child: FutureBuilder(
                                    future: _mapFuture,
                                    builder: (ctx, futureResult) {
                                      if (futureResult.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Center(
                                            child: CircularProgressIndicator());
                                      }
                                      if (!futureResult.hasData ||
                                          futureResult.data == null) {
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Displays Nearby places and shows corresponding message
                verticalSpaceMedium,
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.only(left: marginHorizontal),
                    child: const Text(
                      "Nearby Places",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
                  //Future builder for nearby places
                  child: FutureBuilder(
                    future: _mapFuture,
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
                              child:
                                  Text("Unable to fetch nearby destinations")),
                        );
                      }
                      return DestinationNearbyPlaces(
                          location: futureResult.data!);
                    },
                  ),
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
