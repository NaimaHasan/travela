import 'package:flutter/material.dart';
import 'package:travela/common/api/tripController.dart';

import '../../../common/models/trip.dart';
import '../../itinerary/itinerary_screen.dart';

import 'package:intl/intl.dart';

class TripGrid extends StatefulWidget {
  const TripGrid({Key? key}) : super(key: key);

  @override
  State<TripGrid> createState() => _TripGridState();
}

class _TripGridState extends State<TripGrid> {
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
        if( futureResult.connectionState == ConnectionState.waiting ){
          return CircularProgressIndicator();
        }
        if( !futureResult.hasData || futureResult.data!.isEmpty ){
          return Text("No Trips Yet");
        }
        return GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 80,
            mainAxisSpacing: 50,
            childAspectRatio: 2.2,
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
                        height: 160,
                        width: 160,
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
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(bottom: 45),
                              child: Text(
                                '${DateFormat.MMMMd().format(futureResult.data![index].startDate)}  - ${DateFormat.yMMMMd().format(futureResult.data![index].endDate)}',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.share),
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
