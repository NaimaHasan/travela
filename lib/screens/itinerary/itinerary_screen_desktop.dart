import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:travela/common/api/itinerary_controller.dart';
import 'package:travela/common/models/trip.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_account_circle.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_column.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_users.dart';


import '../../common/api/trip_controller.dart';
import '../../widgets/common/pill_button.dart';
import '../../widgets/common/spacing.dart';
import '../../widgets/common/top_navigation_bar.dart';
import '../account/account_screen.dart';
import 'package:latlong2/latlong.dart';

//A stateless widget for displaying itinerary screen desktop
class ItineraryScreenDesktop extends StatelessWidget {
  //Constructor
  const ItineraryScreenDesktop({super.key, required this.trip});

  final int trip;

  @override
  Widget build(BuildContext context) {
    //Variable for screen size
    var screenSize = MediaQuery.of(context).size;
    //Variable for tab width limit
    var tabWidth = 945;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        //Calls the TopNavigationBar widget
        child: const TopNavigationBar(
          hasSearch: false,
        ),
      ),
      //Calls the main screen widget
      body: MainScreen(trip: trip, tabWidth: tabWidth, screenSize: screenSize),
    );
  }
}

//A stateful widget for displaying itinerary screen desktop
class MainScreen extends StatefulWidget {
  //Constructor
  const MainScreen({
    super.key,
    required this.trip,
    required this.tabWidth,
    required this.screenSize,
  });

  final int trip;
  final int tabWidth;
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
    //Future builder for itinerary screen data
    //Checks the relevant conditions and displays messages on screen accordingly
    return FutureBuilder(
      future: _future,
      builder: (ctx, futureResults) {
        if (futureResults.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!futureResults.hasData) {
          return const Center(child: Text("Trip does not exist."));
        }
        //If anyone that should not have access to the screen tries to access the screen i.e with the link
        //then shows trip does not exist
        var data = futureResults.data![0] as Trip;
        var locations = futureResults.data![1] as List<LatLng>;
        var auth = FirebaseAuth.instance;
        if (data.owner != auth.currentUser!.email! &&
            !data.pendingUsers.contains(auth.currentUser!.email!) &&
            !data.sharedUsers.contains(auth.currentUser!.email!)) {
          return const Center(child: Text("Trip does not exist."));
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: widget.screenSize.width < 1250
                      ? widget.screenSize.width / widget.tabWidth * 26
                      : widget.screenSize.width / widget.tabWidth * 50),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 50),
                    //Displays the trip image if there is one else shows the default image
                    Container(
                      width: 0.15 * widget.screenSize.width,
                      height: 0.15 * widget.screenSize.width,
                      color: data.tripImageUrl == null ? Colors.black12 : null,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: data.tripImageUrl == null
                            ? const Center(
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
                    //Displays the trip name
                    Text(
                      data.tripName,
                      style:
                          const TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Displays the trip duration
                    Text(
                      '${DateFormat.MMMMd().format(DateTime.parse(data.startDate))} - ${DateFormat.yMMMMd().format(DateTime.parse(data.endDate))}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //Displays the created by
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(right: 10),
                            child: Text('Created by:'),
                          ),
                          ItineraryAccountCircle(email: data.owner)
                        ],
                      ),
                    ),
                    //Displays the pill button for edit trip information
                    PillButton(
                      padding: const EdgeInsets.all(10),
                      onPress: () async {
                        await TripController.putTrip(data, context);
                        setState(() {
                          setFutures();
                        });
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: const [
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
                    ),
                    Container(height: 15),
                    //Displays the pill button for sharing trip
                    Row(
                      children: [
                        PillButton(
                          padding: const EdgeInsets.all(10),
                          onPress: () async {
                            await TripController.shareTrip(data, context);
                            setState(() {
                              setFutures();
                            });
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
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
                        ),
                        Container(width: 15),
                        //Displays the pill button for deleting trip
                        PillButton(
                          padding: const EdgeInsets.all(10),
                          onPress: () async {
                            await TripController.deleteTrip(
                                data, context);
                            // ignore: use_build_context_synchronously
                            Navigator.of(context)
                                .pushNamed(AccountScreen.routeName);
                          },
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const [
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
                        ),
                      ],
                    ),
                    Container(height: 15),
                    //Displays the itinerary users
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
            //Displays the itinerary column
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

            //Displays the itinerary map
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
