import 'package:flutter/material.dart';
import 'package:travela/common/api/tripController.dart';

import '../../../common/models/trip.dart';
import '../../itinerary/itinerary_screen.dart';

import 'package:intl/intl.dart';

class ItineraryTopMobile extends StatefulWidget {
  const ItineraryTopMobile({Key? key}) : super(key: key);

  @override
  State<ItineraryTopMobile> createState() => _ItineraryTopMobileState();
}

class _ItineraryTopMobileState extends State<ItineraryTopMobile> {
  late Future<List<Trip>> _getTrips;

  @override
  void initState() {
    _getTrips = TripController.getAllTrips();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return FutureBuilder(
    //   future: _getTrips,
    //   builder: (context, futureResult) {
    //     if (futureResult.connectionState == ConnectionState.waiting) {
    //       return CircularProgressIndicator();
    //     }
    //     if (!futureResult.hasData || futureResult.data!.isEmpty) {
    //       return Text("No Trips Yet");
    //     }
    return Padding(
      padding: EdgeInsets.only(left: 25, right: 25, bottom: 20),
      child: Container(
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
                    padding: EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      'lalalalal', //futureResult.data![index].tripName,
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    'lalalal ssegwewewt', //'${DateFormat.MMMMd().format(futureResult.data![index].startDate)}  - ${DateFormat.yMMMMd().format(futureResult.data![index].endDate)}',
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
    );
    //},
    //);
  }
}
