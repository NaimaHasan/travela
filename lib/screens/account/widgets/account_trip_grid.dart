import 'package:flutter/material.dart';
import 'package:travela/common/api/tripController.dart';

import '../../../common/enums.dart';
import '../../../common/models/trip.dart';
import '../../itinerary/itinerary_screen.dart';

import 'package:intl/intl.dart';

class AccountTripGrid extends StatefulWidget {
  const AccountTripGrid({Key? key, required this.group}) : super(key: key);

  final TripGroup group;

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
    return FutureBuilder(
      future: _getTrips,
      builder: (context, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!futureResult.hasData || futureResult.data!.isEmpty) {
          return Text("No Trips Yet");
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 70,
            mainAxisSpacing: 30,
            childAspectRatio: 2.1,
          ),
          itemCount: futureResult.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed(
                    "${ItineraryScreen.routeName}/${futureResult.data![index].tripID}");
              },
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height:
                            ((MediaQuery.of(context).size.width * 0.75 * 0.5) /
                                    3 -
                                70),
                        width:
                            ((MediaQuery.of(context).size.width * 0.75 * 0.5) /
                                    3 -
                                70),
                        color: Colors.black12,
                        child: Center(
                          child: Icon(Icons.image_not_supported_outlined),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 15, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 15, bottom: 5),
                              child: Text(
                                futureResult.data![index].tripName,
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width /
                                            1450 *
                                            14,
                                    fontWeight: FontWeight.bold),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              '${DateFormat.MMMMd().format(DateTime.parse(futureResult.data![index].startDate))} - ${DateFormat.yMMMMd().format(DateTime.parse(futureResult.data![index].endDate))}',
                              style: TextStyle(
                                  fontSize: MediaQuery.of(context).size.width /
                                      1450 *
                                      12),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Expanded(
                              child: Container(),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 5),
                              child: widget.group == TripGroup.pending
                                  ? Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await TripController.acceptTrip(
                                                futureResult.data![index]);
                                            setState(() {
                                              setFutures();
                                            });
                                          },
                                          icon: Icon(Icons.check),
                                          splashRadius: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1450 *
                                              15,
                                          padding: EdgeInsets.zero,
                                          visualDensity: VisualDensity.compact,
                                          color: Colors.green,
                                          iconSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1450 *
                                              15,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await TripController.declineTrip(
                                                futureResult.data![index]);
                                            setState(() {
                                              setFutures();
                                            });
                                          },
                                          icon: Text(
                                            'X',
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  1450 *
                                                  13,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.red,
                                            ),
                                          ),
                                          splashRadius: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1450 *
                                              14,
                                          padding: EdgeInsets.zero,
                                          visualDensity: VisualDensity.compact,
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          onPressed: () async {
                                            await TripController.deleteTrip(
                                                futureResult.data![index].tripID!, context);
                                            setState(() {
                                              setFutures();
                                            });
                                          },
                                          icon: Icon(Icons.delete_outline),
                                          splashRadius: MediaQuery.of(context)
                                              .size
                                              .width /
                                              1450 *
                                              15,
                                          padding: EdgeInsets.zero,
                                          visualDensity: VisualDensity.compact,
                                          color: Colors.black,
                                          iconSize: MediaQuery.of(context)
                                              .size
                                              .width /
                                              1450 *
                                              15,
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await TripController.shareTrip(
                                                futureResult.data![index],
                                                context);
                                            setState(() {
                                              setFutures();
                                            });
                                          },
                                          icon: Icon(Icons.share),
                                          splashRadius: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1450 *
                                              14,
                                          padding: EdgeInsets.zero,
                                          visualDensity: VisualDensity.compact,
                                          iconSize: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1450 *
                                              14,
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
        );
      },
    );
  }
}
