import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travela/common/api/tripController.dart';
import 'package:travela/common/enums.dart';

import '../../../common/models/trip.dart';
import '../../itinerary/itinerary_screen.dart';

import 'package:intl/intl.dart';

import '../../new_trip/new_trip_screen.dart';

//A stateful widget to display the account trip grid in the browser version
class AccountTripList extends StatefulWidget {
  //Constructor
  const AccountTripList({Key? key, required this.group, required this.name})
      : super(key: key);

  final TripGroup group;
  final String name;

  @override
  State<AccountTripList> createState() => _AccountTripListState();
}

class _AccountTripListState extends State<AccountTripList> {
  late Future<List<Trip>> _getTrips;

  void setFutures() {
    switch (widget.group) {
      case TripGroup.pending:
        _getTrips = TripController.getPendingTrips();
        break;
      case TripGroup.personal:
        _getTrips = TripController.getPersonalTrips();
        break;
      case TripGroup.group:
        _getTrips = TripController.getGroupTrips();
        break;
    }
  }

  @override
  void initState() {
    setFutures();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //Variable to specify the tablet width
    var tabWidth = 1150;
    //Future builder to get user trip information
    return FutureBuilder(
      future: _getTrips,
      builder: (context, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        //Column for the name and "+" icon
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 40,
                  bottom:
                      MediaQuery.of(context).size.width < tabWidth ? 5 : 30),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.name,
                      style: TextStyle(
                          fontSize: MediaQuery.of(context).size.width < tabWidth
                              ? 18
                              : 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  //"+" icon is only visible in case of your trips
                  Visibility(
                    visible: widget.name == 'Your Trips',
                    child: Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(NewTripScreen.routeName);
                          },
                          icon: Icon(
                            Icons.add,
                            size: MediaQuery.of(context).size.width < tabWidth
                                ? 22
                                : 30,
                          ),
                          padding: EdgeInsets.zero,
                          visualDensity: VisualDensity.compact,
                          splashRadius: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            //if there are no trips displays No trips yet else displays a listview
            !futureResult.hasData || futureResult.data!.isEmpty
                ? const Text("No Trips Yet")
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    itemCount: futureResult.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      //If tapped on a trip card routes to its corresponding itinerary screen
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              "${ItineraryScreen.routeName}/${futureResult.data![index].tripID}");
                        },
                        child: Column(
                          children: [
                            //if there is already a trip image displays the trip image
                            //else displays the default icon
                            SizedBox(
                              height: 90,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: futureResult
                                                .data![index].tripImageUrl ==
                                            null
                                        ? Container(
                                            height: 60,
                                            width: 60,
                                            color: Colors.black12,
                                            child: const Center(
                                              child: Icon(Icons
                                                  .image_not_supported_outlined),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 60,
                                            width: 60,
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  "http://127.0.0.1:8000${futureResult.data![index].tripImageUrl!}",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                  ),
                                  //Widget for displaying the trip informations
                                  Padding(
                                    padding: const EdgeInsets.only(left: 15),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 25, bottom: 5),
                                          child: Text(
                                            futureResult.data![index].tripName,
                                            style: const TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        Text(
                                          '${DateFormat.MMMMd().format(DateTime.parse(futureResult.data![index].startDate))} - ${DateFormat.yMMMMd().format(DateTime.parse(futureResult.data![index].endDate))}',
                                          style: const TextStyle(fontSize: 14),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(child: Container()),
                                  //if the trip is in pending group displays the tick and cross icon
                                  //if the tick is pressed, the trip is accepted
                                  //if the cross is pressed, the trip is declined
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 25),
                                    child: widget.group == TripGroup.pending
                                        ? Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  await TripController
                                                      .acceptTrip(futureResult
                                                          .data![index]);
                                                  setState(() {
                                                    setFutures();
                                                  });
                                                },
                                                icon: const Icon(Icons.check),
                                                splashRadius: 18,
                                                padding: EdgeInsets.zero,
                                                visualDensity:
                                                    VisualDensity.compact,
                                                color: Colors.green,
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  await TripController
                                                      .declineTrip(futureResult
                                                          .data![index]);
                                                  setState(() {
                                                    setFutures();
                                                  });
                                                },
                                                icon: const Text(
                                                  'X',
                                                  style: TextStyle(
                                                    fontSize: 19,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                splashRadius: 18,
                                                padding: EdgeInsets.zero,
                                                visualDensity:
                                                    VisualDensity.compact,
                                              ),
                                            ],
                                          )
                                        //if the trip is in your trip or you group trip group displays the delete and share icon
                                        //if the delete is pressed, the trip is deleted
                                        //if the share is pressed, the share dialogue is displayed
                                        : Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  await TripController
                                                      .deleteTrip(
                                                          futureResult
                                                              .data![index],
                                                          context);
                                                  setState(() {
                                                    setFutures();
                                                  });
                                                },
                                                icon: const Icon(
                                                    Icons.delete_outline),
                                                iconSize: 18,
                                                splashRadius: 18,
                                                padding: EdgeInsets.zero,
                                                visualDensity:
                                                    VisualDensity.compact,
                                                color: Colors.black,
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  await TripController
                                                      .shareTrip(
                                                          futureResult
                                                              .data![index],
                                                          context);
                                                  setState(() {
                                                    setFutures();
                                                  });
                                                },
                                                icon: const Icon(Icons.share),
                                                iconSize: 17,
                                                splashRadius: 17,
                                                padding: EdgeInsets.zero,
                                                visualDensity:
                                                    VisualDensity.compact,
                                              ),
                                            ],
                                          ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 0.75,
                              width: MediaQuery.of(context).size.width - 40,
                              color: Colors.black38,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ],
        );
      },
    );
  }
}
