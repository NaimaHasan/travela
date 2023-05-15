import 'package:flutter/material.dart';
import 'package:travela/common/api/itineraryController.dart';
import 'package:travela/common/models/itineraryEntry.dart';

import '../../../common/models/trip.dart';

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
    var tabWidth = 945;
    var screenWidth = MediaQuery.of(context).size.width;
    var factor = (screenWidth / tabWidth) * 0.8;
    return Stack(
      alignment: Alignment.center,
      children: [
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
                SizedBox(
                  width: screenWidth > tabWidth
                      ? factor + 15
                      : screenWidth / 450 * 40,
                ),
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
