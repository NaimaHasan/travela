import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travela/common/api/itineraryController.dart';

import '../../../common/models/trip.dart';
import 'itinerary_header.dart';
import 'itinerary_item.dart';

class ItineraryColumn extends StatelessWidget {
  const ItineraryColumn({Key? key, required this.trip}) : super(key: key);

  final Trip trip;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FutureBuilder(
        future: ItineraryController.getAllEntries(trip.tripID!),
        builder: (ctx, futureResult) {
          if (futureResult.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!futureResult.hasData) {
            return Text("No Itinerary Entries");
          }
          return ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 5),
            itemCount: futureResult.data!.length,
            itemBuilder: (BuildContext context, int index) {
              var data = futureResult.data![index];
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Visibility(
                    child: ItineraryHeader(
                      text: "${DateFormat.E().format(data.dateTime)}, ${DateFormat.MMMd().format(data.dateTime)}",
                      isMiddle: index != 0,
                    ),
                    visible: index == 0 ? true : futureResult.data![index].dateTime.difference(futureResult.data![index-1].dateTime).inDays >= 1,
                  ),
                  ItineraryItem(
                    time: DateFormat.Hm().format(data.dateTime),
                    description: data.description,
                    isStart: index == 0,
                    isEnd: index == futureResult.data!.length - 1,
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

// ItineraryHeader(
//   text: "Sun, 19th March",
// ),
// ItineraryItem(time: "6:00 AM", description: "Start of Trip", isStart: true,),
// ItineraryHeader(
//   text: "Thu, 23rd March",
//   isMiddle: true,
// ),
// ItineraryItem(time: "6:00 AM", description: "End of Trip", isEnd: true),
