import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travela/common/api/tripController.dart';

import '../../../common/models/trip.dart';
import '../../account/account_screen.dart';
import '../../itinerary/itinerary_screen.dart';

import 'package:intl/intl.dart';

import 'itinerary_account_circle.dart';

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
            height: 100,
            width: 100,
            color: trip.tripImageUrl == null ? Colors.black12 : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: trip.tripImageUrl == null
                  ? Center(
                      child: Icon(
                        Icons.image_not_supported_outlined,
                        size: 30,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: "http://127.0.0.1:8000${trip.tripImageUrl!}",
                      fit: BoxFit.cover,
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
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 10),
                        child: Text('Created by:'),
                      ),
                      ItineraryAccountCircle(email: trip.owner)
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: Container()),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
            splashRadius: 16,
          ),
          Container(width: 5),
          IconButton(
            onPressed: () async {
              await TripController.deleteTrip(trip.tripID!, context);
              Navigator.of(context).pushNamed(AccountScreen.routeName);
            },
            icon: Icon(Icons.delete_outline),
            splashRadius: 16,
          ),
          Container(width: 5),
          IconButton(
            onPressed: () async {
              await TripController.shareTrip(trip, context);
            },
            icon: Icon(Icons.share),
            splashRadius: 16,
          ),
        ],
      ),
    );
    //},
    //);
  }
}
