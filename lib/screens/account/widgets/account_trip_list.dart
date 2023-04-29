import 'package:flutter/material.dart';
import 'package:travela/common/api/tripController.dart';

import '../../../common/models/trip.dart';
import '../../itinerary/itinerary_screen.dart';

import 'package:intl/intl.dart';

class AccountTripList extends StatefulWidget {
  const AccountTripList({Key? key}) : super(key: key);

  @override
  State<AccountTripList> createState() => _AccountTripListState();
}

class _AccountTripListState extends State<AccountTripList> {
  late Future<List<Trip>> _getTrips;

  @override
  void initState() {
    _getTrips = TripController.getAllTrips();
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
                Navigator.of(context).pushNamed(ItineraryScreen.routeName);
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
                                '${DateFormat.MMMMd().format(DateTime.parse(futureResult.data![index].startDate))}  - ${DateFormat.yMMMMd().format(DateTime.parse(futureResult.data![index].endDate))}',
                                style: TextStyle(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Expanded(child: Container()),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.share),
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
