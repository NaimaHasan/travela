import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:travela/common/api/itineraryController.dart';
import 'package:travela/common/models/trip.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_column.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_header.dart';
import 'package:travela/screens/itinerary/widgets/itinerary_item.dart';
import 'package:travela/widgets/common/variable_map.dart';

import '../../common/api/tripController.dart';
import '../../widgets/common/pill_button.dart';
import '../../widgets/common/spacing.dart';
import '../../widgets/common/top_navigation_bar.dart';
import '../account/account_screen.dart';

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
        if (!futureResults.hasData) {
          return Center(
            child: Text("Trip does not exist."),
          );
        }
        var data = futureResults.data!;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal:
                      MediaQuery.of(context).size.width / widget.tabwidth * 45),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 0.16 * widget.screenSize.width,
                    height: 0.16 * widget.screenSize.width,
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
                          : Image.network(
                              "http://127.0.0.1:8000${data.tripImageUrl!}",
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  verticalSpaceSmall,
                  Text(
                    data.tripName,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
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
                  Row(
                    children: [
                      PillButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Share",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                        },
                      ),
                      Container(
                        width: 15,
                      ),
                      PillButton(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Delete",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
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
                ],
              ),
            ),
            Expanded(
              child: ItineraryColumn(
                trip: futureResults.data!,
                isScrollable: true,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: VariableMap(
                      getCenter:
                          ItineraryController.getFirstLocation(data.tripID!),
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
