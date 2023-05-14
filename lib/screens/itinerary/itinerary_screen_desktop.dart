import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:travela/common/api/itineraryController.dart';
import 'package:travela/common/models/trip.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_account_circle.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_column.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_header.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_item.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_users.dart';
import 'package:travela/widgets/common/variable_map.dart';

import '../../common/api/tripController.dart';
import '../../common/api/userController.dart';
import '../../widgets/common/pill_button.dart';
import '../../widgets/common/spacing.dart';
import '../../widgets/common/top_navigation_bar.dart';
import '../account/account_screen.dart';
import 'package:latlong2/latlong.dart';

class ItineraryScreenDesktop extends StatelessWidget {
  const ItineraryScreenDesktop({super.key, required this.trip});

  final int trip;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    var tabwidth = 945;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        child: const TopNavigationBar(
          hasSearch: false,
        ),
      ),
      body: MainScreen(trip: trip, tabwidth: tabwidth, screenSize: screenSize),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({
    super.key,
    required this.trip,
    required this.tabwidth,
    required this.screenSize,
  });

  final int trip;
  final int tabwidth;
  final Size screenSize;

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
          return Center(child: CircularProgressIndicator());
        }
        if (!futureResults.hasData) {
          return Center(child: Text("Trip does not exist."));
        }
        var data = futureResults.data![0] as Trip;
        var locations = futureResults.data![1] as List<LatLng>;
        var auth = FirebaseAuth.instance;
        if (data.owner != auth.currentUser!.email! &&
            !data.pendingUsers.contains(auth.currentUser!.email!) &&
            !data.sharedUsers.contains(auth.currentUser!.email!)) {
          return Center(child: Text("Trip does not exist."));
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.screenSize.width < 1250
                      ? widget.screenSize.width / widget.tabwidth * 26
                      : widget.screenSize.width / widget.tabwidth * 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    SizedBox(height: 50),
                    Container(
                      width: 0.15 * widget.screenSize.width,
                      height: 0.15 * widget.screenSize.width,
                      color: data.tripImageUrl == null ? Colors.black12 : null,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: data.tripImageUrl == null
                            ? Center(
                                child: Icon(
                                  Icons.image_not_supported_outlined,
                                  size: 30,
                                ),
                              )
                            : CachedNetworkImage(
                                imageUrl: "http://127.0.0.1:8000${data.tripImageUrl!}",
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                    verticalSpaceSmall,
                    Text(
                      data.tripName,
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '${DateFormat.MMMMd().format(DateTime.parse(data.startDate))} - ${DateFormat.yMMMMd().format(DateTime.parse(data.endDate))}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text('Created by:'),
                          ),
                          ItineraryAccountCircle(email: data.owner)
                        ],
                      ),
                    ),
                    PillButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Edit",
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.edit,
                            color: Colors.black,
                            size: 16,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(10),
                      onPress: () async {
                        await TripController.putTrip(data, context);
                        setState(() {
                          setFutures();
                        });
                      },
                    ),
                    Container(height: 15),
                    Row(
                      children: [
                        PillButton(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Share",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.share,
                                color: Colors.black,
                                size: 16,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          onPress: () async {
                            await TripController.shareTrip(data, context);
                            setState(() {
                              setFutures();
                            });
                          },
                        ),
                        Container(width: 15),
                        PillButton(
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "Delete",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.delete_outline,
                                color: Colors.black,
                                size: 16,
                              ),
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                          onPress: () async {
                            await TripController.deleteTrip(
                                data.tripID!, context);
                            Navigator.of(context)
                                .pushNamed(AccountScreen.routeName);
                          },
                        ),
                      ],
                    ),
                    Container(height: 15),
                    ItineraryUsers(
                      userList: data.sharedUsers,
                      name: 'Shared',
                    ),
                    Container(height: 15),
                    ItineraryUsers(
                      userList: data.pendingUsers,
                      name: 'Pending',
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ItineraryColumn(
                trip: data,
                isScrollable: true,
                refreshMarkers: () {
                  setState(() {
                    setFutures();
                  });
                },
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
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
                ],
              ),
            )
          ],
        );
      },
    );
  }
}
