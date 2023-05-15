import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:travela/common/api/trip_controller.dart';

import '../../../common/models/trip.dart';
import '../../account/account_screen.dart';

import 'package:intl/intl.dart';

import 'itinerary_account_circle.dart';

//A stateless widget for displaying the itinerary top part of the screen for mobile version
class ItineraryTopMobile extends StatelessWidget {
  //Constructor
  const ItineraryTopMobile({Key? key, required this.trip}) : super(key: key);

  final Trip trip;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
      child: Row(
        children: [
          Container(
            height: 100,
            width: 100,
            color: trip.tripImageUrl == null ? Colors.black12 : null,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              //if there is no trip image displays an icon, otherwise displays the trip image
              child: trip.tripImageUrl == null
                  ? const Center(
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
          //Displays the trip information
          //Displays trip name, trip duration, created by, share button and delete button and share button
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  //Displays trip name
                  child: Text(
                    trip.tripName,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                //Displays trip duration
                Text(
                  '${DateFormat.MMMMd().format(DateTime.parse(trip.startDate))}  - ${DateFormat.yMMMMd().format(DateTime.parse(trip.endDate))}',
                  style: const TextStyle(fontSize: 14),
                ),
                //Displays created by
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    children: [
                      const Padding(
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
          //Displays the edit icon
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit),
            splashRadius: 16,
          ),
          Container(width: 5),
          //Displays the delete icon
          IconButton(
            onPressed: () async {
              await TripController.deleteTrip(trip, context);
              // ignore: use_build_context_synchronously
              Navigator.of(context).pushNamed(AccountScreen.routeName);
            },
            icon: const Icon(Icons.delete_outline),
            splashRadius: 16,
          ),
          Container(width: 5),
          //Displays the share button
          IconButton(
            onPressed: () async {
              await TripController.shareTrip(trip, context);
            },
            icon: const Icon(Icons.share),
            splashRadius: 16,
          ),
        ],
      ),
    );
    //},
    //);
  }
}
