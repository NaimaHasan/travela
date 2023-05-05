import 'package:flutter/material.dart';
import 'package:travela/common/api/tripController.dart';
import 'package:travela/common/enums.dart';

import '../../../common/models/trip.dart';
import '../../itinerary/itinerary_screen.dart';

import 'package:intl/intl.dart';

class AccountTripList extends StatefulWidget {
  const AccountTripList({Key? key, required this.group}) : super(key: key);

  final TripGroup group;

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
    return FutureBuilder(
      future: _getTrips,
      builder: (context, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (!futureResult.hasData || futureResult.data!.isEmpty) {
          return Text("No Trips Yet");
        }
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          itemCount: futureResult.data!.length,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                Navigator.of(context).pushNamed("${ItineraryScreen.routeName}/${futureResult.data![index].tripID}");
              },
              child: Column(
                children: [
                  Container(
                    height: 90,
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 10),
                          child: Container(
                            height: 60,
                            width: 60,
                            color: Colors.tealAccent,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 25, bottom: 5),
                                child: Text(
                                  futureResult.data![index].tripName,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '${DateFormat.MMMMd().format(DateTime.parse(futureResult.data![index].startDate))} - ${DateFormat.yMMMMd().format(DateTime.parse(futureResult.data![index].endDate))}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        Padding(
                          padding: EdgeInsets.only(bottom: 25),
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
                                      splashRadius: 18,
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                      color: Colors.green,
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
                                          fontSize: 19,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.red,
                                        ),
                                      ),
                                      splashRadius: 18,
                                      padding: EdgeInsets.zero,
                                      visualDensity: VisualDensity.compact,
                                    ),
                                  ],
                                )
                              : IconButton(
                                  onPressed: () async {
                                    await TripController.shareTrip(
                                        futureResult.data![index], context);
                                    setState(() {
                                      setFutures();
                                    });
                                  },
                                  icon: Icon(Icons.share),
                                  splashRadius: 18,
                                  padding: EdgeInsets.zero,
                                  visualDensity: VisualDensity.compact,
                                ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    width: MediaQuery.of(context).size.width - 40,
                    color: Colors.black45,
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
