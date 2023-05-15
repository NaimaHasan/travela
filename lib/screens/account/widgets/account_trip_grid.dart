import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travela/common/api/tripController.dart';

import '../../../common/enums.dart';
import '../../../common/models/trip.dart';
import '../../itinerary/itinerary_screen.dart';

import 'package:intl/intl.dart';

import '../../new_trip/new_trip_screen.dart';

//A stateful widget to display the account trip grid in the browser version
class AccountTripGrid extends StatefulWidget {
  const AccountTripGrid({Key? key, required this.group, required this.name})
      : super(key: key);

  final TripGroup group;
  final String name;

  @override
  State<AccountTripGrid> createState() => _AccountTripGridState();
}

class _AccountTripGridState extends State<AccountTripGrid> {
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
    //Variable for screen size
    var screenSize = MediaQuery.of(context).size;
    //Variable for scaling factor
    var factor = screenSize.width / 1450;
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
                          fontSize: screenSize.width < tabWidth ? 18 : 24,
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
                            size: screenSize.width < tabWidth ? 22 : 30,
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
            //if there are no trips displays No trips yet else displays a gridview
            !futureResult.hasData || futureResult.data!.isEmpty
                ? const Text("No Trips Yet")
                : GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 70,
                      mainAxisSpacing: 30,
                      childAspectRatio: 2.1,
                    ),
                    itemCount: futureResult.data!.length,
                    itemBuilder: (BuildContext context, int index) {
                      //If tapped on a trip card routes to its corresponding itinerary screen
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).pushNamed(
                              "${ItineraryScreen.routeName}/${futureResult.data![index].tripID}");
                        },
                        child: Card(
                          elevation: 5,
                          child: Row(
                            children: [
                              //if there is already a trip image displays the trip image
                              //else displays the default icon
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: futureResult.data![index].tripImageUrl ==
                                        null
                                    ? Container(
                                        height: screenSize.width * 0.125 - 70,
                                        width: screenSize.width * 0.125 - 70,
                                        color: Colors.black12,
                                        child: const Center(
                                          child: Icon(Icons
                                              .image_not_supported_outlined),
                                        ),
                                      )
                                    : SizedBox(
                                        height: screenSize.width * 0.125 - 70,
                                        width: screenSize.width * 0.125 - 70,
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              "http://127.0.0.1:8000${futureResult.data![index].tripImageUrl!}",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                              ),
                              //Widget for displaying the trip informations
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 15, left: 15),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 15, bottom: 5),
                                        child: Text(
                                          futureResult.data![index].tripName,
                                          style: TextStyle(
                                              fontSize: factor * 14.0,
                                              fontWeight: FontWeight.bold),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      Text(
                                        '${DateFormat.MMMMd().format(DateTime.parse(futureResult.data![index].startDate))} - ${DateFormat.yMMMMd().format(DateTime.parse(futureResult.data![index].endDate))}',
                                        style: TextStyle(fontSize: factor * 12),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Expanded(
                                        child: Container(),
                                      ),
                                      //if the trip is in pending group displays the tick and cross icon
                                      //if the tick is pressed, the trip is accepted
                                      //if the cross is pressed, the trip is declined
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: widget.group == TripGroup.pending
                                            ? Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      await TripController
                                                          .acceptTrip(
                                                              futureResult
                                                                      .data![
                                                                  index]);
                                                      setState(() {
                                                        setFutures();
                                                      });
                                                    },
                                                    icon:
                                                        const Icon(Icons.check),
                                                    splashRadius: factor * 15,
                                                    padding: EdgeInsets.zero,
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    color: Colors.green,
                                                    iconSize: factor * 15,
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await TripController
                                                          .declineTrip(
                                                              futureResult
                                                                      .data![
                                                                  index]);
                                                      setState(() {
                                                        setFutures();
                                                      });
                                                    },
                                                    icon: Text(
                                                      'X',
                                                      style: TextStyle(
                                                        fontSize: factor * 15,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    splashRadius: factor * 15,
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
                                                                  .data![index]
                                                                  .tripID!,
                                                              context);
                                                      setState(() {
                                                        setFutures();
                                                      });
                                                    },
                                                    icon: const Icon(
                                                        Icons.delete_outline),
                                                    splashRadius: factor * 15,
                                                    padding: EdgeInsets.zero,
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    color: Colors.black,
                                                    iconSize: factor * 15,
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
                                                    icon:
                                                        const Icon(Icons.share),
                                                    splashRadius: factor * 14,
                                                    padding: EdgeInsets.zero,
                                                    visualDensity:
                                                        VisualDensity.compact,
                                                    iconSize: factor * 14,
                                                  ),
                                                ],
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
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
