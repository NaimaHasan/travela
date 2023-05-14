import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travela/common/api/destinationController.dart';
import 'package:travela/common/api/locationController.dart';
import 'package:travela/screens/destination/widgets/destination_image.dart';
import 'package:travela/screens/destination/widgets/destination_nearby.dart';

import '../../common/models/destination.dart';
import '../../widgets/common/spacing.dart';
import '../../widgets/common/top_navigation_bar.dart';
import 'package:latlong2/latlong.dart';

class DestinationScreenDesktop extends StatefulWidget {
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
  late Future<List<Destination>> _nearbyFuture;

  @override
  void initState() {
    _future = DestinationController.getDestination(widget.destinationName);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        child: const TopNavigationBar(
          hasSearch: false,
        ),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (ctx, futureResult) {
          if (futureResult.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!futureResult.hasData || futureResult.data == null) {
            return Center(
              child: Text("No destination by that name"),
            );
          }
          _mapFuture = LocationController.getDestinationLocation(
              futureResult.data!.name);
          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DestinationImage(
                  destination: futureResult.data!,
                ),
                verticalSpaceMedium,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 0.5 * screenSize.width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Address",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            verticalSpaceSmall,
                            Text(
                              futureResult.data!.address,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            verticalSpaceMedium,
                            Text(
                              "Description",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            verticalSpaceSmall,
                            Text(
                              futureResult.data!.description!,
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            verticalSpaceMedium,
                            Text(
                              "Things to do",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            verticalSpaceSmall,
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 7, right: 8),
                                  child: CircleAvatar(
                                    radius: 4,
                                    backgroundColor: Colors.black,
                                    foregroundColor: Colors.black,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    "Lorem ipsum dolor sit amet consectetur. Est commodo senectus purus porttitor quisque non sem eu tempus."
                                    " Ac ullamcorper sagittis cras non ornare ac neque. Blandit tincidunt diam",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 150),
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "Location",
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Expanded(child: Container()),
                                Icon(Icons.location_on),
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
                                    return Center(
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
                    ],
                  ),
                ),
                verticalSpaceMedium,
                Align(
                  child: Padding(
                    padding: EdgeInsets.only(left: marginHorizontal),
                    child: Text(
                      "Nearby Places",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  alignment: Alignment.centerLeft,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
                  child: FutureBuilder(
                    future: _mapFuture,
                    builder: (ctx, futureResult) {
                      if (futureResult.connectionState ==
                          ConnectionState.waiting) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (!futureResult.hasData || futureResult.data == null) {
                        return Center(child: Text("Unable to fetch nearby destinations"));
                      }
                      return DestinationNearbyPlaces(location: futureResult.data!);
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
