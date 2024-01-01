import 'package:flutter/material.dart';
import 'package:travela/common/api/itinerary_controller.dart';
import 'package:travela/common/models/itinerary_entry.dart';

import '../../../common/models/trip.dart';

//A stateless widget for displaying the itinerary item
class ItineraryItem extends StatelessWidget {
  //Constructor
  const ItineraryItem(
      {Key? key,
      required this.time,
      required this.description,
      this.isStart = false,
      this.isEnd = false,
      required this.entry,
      required this.refresh,
      required this.isNext,
      required this.trip})
      : super(key: key);

  final String time;
  final String description;
  final bool isStart;
  final bool isEnd;
  final ItineraryEntry entry;
  final VoidCallback refresh;
  final bool isNext;
  final Trip trip;

  @override
  Widget build(BuildContext context) {
    //Variable for tablet width limit
    var tabWidth = 945;
    //Variable for screen size
    var screenWidth = MediaQuery.of(context).size.width;
    //Scaling factor for responsiveness
    var factor = (screenWidth / tabWidth) * 0.8;

    return Stack(
      alignment: Alignment.center,
      children: [
        //Displays the itinerary entry time
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenWidth > tabWidth ? factor * 4 : 15,
              horizontal: 25),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  width: screenWidth > tabWidth ? factor * 115 : 190,
                  child: Text(
                    time,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                //Padding
                SizedBox(
                  width: screenWidth > tabWidth
                      ? factor + 15
                      : screenWidth / 450 * 40,
                ),
                //Displays the itinerary entry description
                SizedBox(
                  width: screenWidth > tabWidth
                      ? factor * 100
                      : screenWidth / 450 * 70,
                  child: Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(child: Container()),

                //Delete button is displayed for deleting entry for all entries other than start of trip and end of trip
                Visibility(
                  visible: entry.description != "Start of Trip" &&
                      entry.description != "End of Trip",
                  child: IconButton(
                    onPressed: () async {
                      await ItineraryController.deleteEntry(context, entry);
                      refresh();
                    },
                    icon: const Icon(Icons.delete_outline),
                    iconSize: 18,
                    splashRadius: 18,
                  ),
                ),

                //Edit icon for editing itinerary entry
                IconButton(
                  onPressed: () async {
                    await ItineraryController.editEntry(context, entry, trip);
                    refresh();
                  },
                  icon: const Icon(Icons.edit),
                  iconSize: 18,
                  splashRadius: 18,
                ),
              ],
            ),
          ),
        ),

        //Displays the blue line in the itinerary item
        Positioned(
          left: screenWidth > tabWidth ? factor * 125 : 180,
          top: isStart ? 30 : 0,
          child: Container(
            height: isStart || isEnd ? (screenWidth > tabWidth ? 30 : 40) : 70,
            width: 8,
            decoration: const BoxDecoration(
              color: Colors.lightBlue,
            ),
          ),
        ),

        //Displays the blue circle in the itinerary item
        Positioned(
          left: screenWidth > tabWidth ? factor * 125 - 6.25 : 180 - 6.25,
          child: CircleAvatar(
              radius: 10,
              backgroundColor:
                  isNext ? Colors.deepOrangeAccent : Colors.lightBlue),
        ),
      ],
    );
  }
}
