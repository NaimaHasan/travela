import 'package:flutter/material.dart';
import 'package:travela/common/api/tripController.dart';

import '../../../common/models/trip.dart';
import '../../itinerary/itinerary_screen.dart';

import 'package:intl/intl.dart';

class AccountTripGrid extends StatefulWidget {
  const AccountTripGrid({Key? key}) : super(key: key);

  @override
  State<AccountTripGrid> createState() => _AccountTripGridState();
}

class _AccountTripGridState extends State<AccountTripGrid> {
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
                Navigator.of(context).pushNamed(ItineraryScreen.routeName);
              },
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Container(
                        height:
                            (MediaQuery.of(context).size.width * 0.75 * 0.5) /
                                    3 -
                                70,
                        width:
                            (MediaQuery.of(context).size.width * 0.75 * 0.5) /
                                    3 -
                                70,
                        color: Colors.tealAccent,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 25, bottom: 10),
                              child: Text(
                                futureResult.data![index].tripName,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '${DateFormat.MMMMd().format(futureResult.data![index].startDate)}  - ${DateFormat.yMMMMd().format(futureResult.data![index].endDate)}',
                              style: TextStyle(fontSize: 16),
                            ),
                            Expanded(
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(Icons.share),
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
