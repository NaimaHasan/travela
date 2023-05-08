import 'package:flutter/material.dart';
import 'package:travela/common/api/tripController.dart';

import '../../../common/models/trip.dart';
import '../../account/account_screen.dart';
import '../../itinerary/itinerary_screen.dart';

import 'package:intl/intl.dart';

class ItineraryTopMobile extends StatelessWidget {
  const ItineraryTopMobile({Key? key, required this.trip}) : super(key: key);

  final Trip trip;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            color: Colors.black12,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Center(
                child: Icon(
                  Icons.image_not_supported_outlined,
                  size: 16,
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    trip.tripName,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '${DateFormat.MMMMd().format(DateTime.parse(trip.startDate))}  - ${DateFormat.yMMMMd().format(DateTime.parse(trip.endDate))}',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () async {
              await TripController.deleteTrip(trip.tripID!, context);
              Navigator.of(context).pushNamed(AccountScreen.routeName);
            },
            icon: Icon(Icons.delete_outline),
          ),
          Container(width: 5),
          IconButton(
            onPressed: () async {
              await TripController.shareTrip(trip, context);
            },
            icon: Icon(Icons.share),
          ),
        ],
      ),
    );
    //},
    //);
  }
}
