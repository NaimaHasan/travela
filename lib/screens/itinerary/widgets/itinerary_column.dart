import 'package:flutter/material.dart';

import 'itinerary_header.dart';
import 'itinerary_item.dart';

class ItineraryColumn extends StatelessWidget {
  const ItineraryColumn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ItineraryHeader(
            text: "Sun, 19th March",
          ),
          ItineraryItem(time: "6:00 AM", description: "Start of Trip", isStart: true,),
          ItineraryHeader(
            text: "Thu, 23rd March",
            isMiddle: true,
          ),
          ItineraryItem(time: "6:00 AM", description: "End of Trip", isEnd: true),
        ],
      ),
    );
  }
}
