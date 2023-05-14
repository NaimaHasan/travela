
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travela/screens/destination/widgets/destination_image.dart';
import 'package:travela/screens/destination/widgets/destination_image_mobile.dart';
import 'package:travela/screens/destination/widgets/destination_nearby.dart';
import 'package:travela/screens/destination/widgets/destination_nearby_mobile.dart';

import '../../common/api/destinationController.dart';
import '../../common/api/locationController.dart';
import '../../common/models/destination.dart';
import '../../widgets/common/top_navigation_bar.dart';
import 'package:latlong2/latlong.dart';

class DestinationScreenMobile extends StatefulWidget {
  const DestinationScreenMobile({Key? key, required this.destinationName}) : super(key: key);

  final String destinationName;

  @override
  State<DestinationScreenMobile> createState() => _DestinationScreenMobileState();
}

class _DestinationScreenMobileState extends State<DestinationScreenMobile> {
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
        builder: (ctx, futureResult){
          if(futureResult.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if(!futureResult.hasData || futureResult.data == null){
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
                DestinationImageMobile(
                  destination: futureResult.data!,
                ),
                const Padding(
                  padding:
                  EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 30),
                  child: Text(
                    'Address',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    futureResult.data!.address,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                const Padding(
                  padding:
                  EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 30),
                  child: Text(
                    'Description',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    futureResult.data!.description!,
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 15, top: 30),
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
                const Padding(
                  padding:
                  EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 30),
                  child: Text(
                    'Things to do',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: Text(
                    'daoiholwfh awdbwak ldbqlwd awdsn;owa bfwoabfiwua lhfqiwsba ADHAWJD KBAWHIBD DABNAJKSBF JAKBFJA',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 15, right: 15, bottom: 10, top: 40),
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
                FutureBuilder(
                  future: _mapFuture,
                  builder: (ctx, futureResult) {
                    if (futureResult.connectionState ==
                        ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (!futureResult.hasData || futureResult.data == null) {
                      return Center(child: Text("Unable to fetch nearby destinations"));
                    }
                    return DestinationNearbyPlacesMobile(location: futureResult.data!);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}