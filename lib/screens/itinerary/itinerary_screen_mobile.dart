import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_column.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_header.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_item.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_top_mobile.dart';

import '../../common/api/itineraryController.dart';
import '../../common/api/tripController.dart';
import '../../common/models/trip.dart';
import '../../widgets/common/pill_button.dart';
import '../../widgets/common/spacing.dart';
import '../../widgets/common/top_navigation_bar.dart';

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
  late Future<Trip?> _future;

  @override
  void initState() {
    _future = TripController.getTripDetails(widget.trip);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (ctx, futureResults) {
        if (futureResults.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }
        var data = futureResults.data!;
        return Container(
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
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30, top: 30, right: 30, bottom: 20),
                        child: Row(
                          children: [
                            Text(
                              'Map',
                              style: TextStyle(fontSize: 24),
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.location_on_outlined,
                              color: Colors.black38,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.35,
                        child: FlutterMap(
                          options: MapOptions(),
                          children: [
                            TileLayer(
                              urlTemplate:
                                  'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                              userAgentPackageName:
                                  'dev.fleaflet.flutter_map.example',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30, bottom: 20, right: 30, top: 30),
                        child: Row(
                          children: [
                            Text(
                              'Itinerary',
                              style: TextStyle(fontSize: 24),
                            ),
                            Expanded(child: Container()),
                            Icon(
                              Icons.calendar_today_outlined,
                              color: Colors.black38,
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: ItineraryColumn(
                        trip: data,
                        isScrollable: false,
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
                    await ItineraryController.newEntry(context, data.tripID!);
                    setState(() {
                      _future = ItineraryController.getAllEntries(data.tripID!)
                          as Future<Trip?>;
                    });
                  },
                  child: Icon(Icons.add),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
