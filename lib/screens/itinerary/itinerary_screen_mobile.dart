import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_column.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_top_mobile.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_users.dart';

import '../../common/api/itineraryController.dart';
import '../../common/api/tripController.dart';
import '../../common/models/trip.dart';
import '../../widgets/common/top_navigation_bar.dart';
import 'package:latlong2/latlong.dart';

class ItineraryScreenMobile extends StatelessWidget {
  const ItineraryScreenMobile({super.key, required this.trip});

  final int trip;

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
      body: MainScreen(trip: trip),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.trip,
  });

  final int trip;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late Future<List<dynamic>> _future;
  final MapController _controller = MapController();

  void setFutures() {
    _future = Future.wait([
      TripController.getTripDetails(widget.trip),
      ItineraryController.getAllLocations(widget.trip)
    ]);
  }

  @override
  void initState() {
    setFutures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (ctx, futureResults) {
        if (futureResults.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!futureResults.hasData) {
          return const Center(child: Text("Trip does not exist."));
        }
        var data = futureResults.data![0] as Trip;
        var locations = futureResults.data![1] as List<LatLng>;
        return SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItineraryTopMobile(
                      trip: data,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: ItineraryUsers(
                        userList: data.sharedUsers,
                        name: 'Shared',
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: ItineraryUsers(
                        userList: data.pendingUsers,
                        name: 'Pending',
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 15, right: 30, bottom: 20),
                        child: Row(
                          children: [
                            const Text(
                              'Map',
                              style: TextStyle(fontSize: 24),
                            ),
                            Expanded(child: Container()),
                            const Icon(
                              Icons.location_on_outlined,
                              color: Colors.black38,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: FlutterMap(
                          mapController: _controller,
                          options: MapOptions(
                            center: locations[0],
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
                                for (var location in locations)
                                  Marker(
                                    width: 150.0,
                                    height: 150.0,
                                    point: location,
                                    builder: (ctx) => const Icon(
                                      Icons.location_on,
                                      color: Colors.red,
                                      size: 35.0,
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, bottom: 20, right: 30, top: 30),
                        child: Row(
                          children: [
                            const Text(
                              'Itinerary',
                              style: TextStyle(fontSize: 24),
                            ),
                            Expanded(child: Container()),
                            const Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.black38,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: ItineraryColumn(
                        trip: data,
                        isScrollable: false,
                        refreshMarkers: () {
                          setState(() {
                            setFutures();
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: () async {
                    await ItineraryController.newEntry(context, data.tripID!, data);
                    setState(() {
                      setFutures();
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
