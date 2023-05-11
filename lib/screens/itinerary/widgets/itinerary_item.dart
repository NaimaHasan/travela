import 'package:flutter/material.dart';
import 'package:travela/common/api/itineraryController.dart';
import 'package:travela/common/models/itineraryEntry.dart';
import 'package:travela/widgets/common/spacing.dart';

class ItineraryItem extends StatelessWidget {
  const ItineraryItem(
      {Key? key,
      required this.time,
      required this.description,
      this.isStart = false,
      this.isEnd = false,
      required this.entry,
      required this.refresh,
      required this.isNext})
      : super(key: key);

  final String time;
  final String description;
  final bool isStart;
  final bool isEnd;
  final ItineraryEntry entry;
  final VoidCallback refresh;
  final bool isNext;

  @override
  Widget build(BuildContext context) {
    var tabwidth = 945;
    var screenwidth = MediaQuery.of(context).size.width;
    var factor = (screenwidth / tabwidth) * 0.8;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: screenwidth > tabwidth ? factor * 4 : 15,
              horizontal: 25),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  width: screenwidth > tabwidth ? factor * 115 : 190,
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: screenwidth > tabwidth
                      ? factor + 15
                      : screenwidth / 450 * 40,
                ),
                SizedBox(
                  width: screenwidth > tabwidth
                      ? factor * 100
                      : screenwidth / 450 * 70,
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(child: Container()),
                IconButton(
                  onPressed: () async {
                    await ItineraryController.deleteEntry(context, entry);
                    refresh();
                  },
                  icon: Icon(Icons.delete_outline),
                  iconSize: screenwidth > tabwidth ? factor * 14 : 18,
                  splashRadius:
                  ((screenwidth > tabwidth ? factor * 14 : 18) / 2) + 5,
                ),
                IconButton(
                  onPressed: () async {
                    await ItineraryController.editEntry(context, entry);
                    refresh();
                  },
                  icon: Icon(Icons.edit),
                  iconSize: screenwidth > tabwidth ? factor * 14 : 18,
                  splashRadius:
                      ((screenwidth > tabwidth ? factor * 14 : 18) / 2) + 5,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: screenwidth > tabwidth ? factor * 125 : 180,
          top: isStart ? 30 : 0,
          child: Container(
            height: isStart || isEnd ? (screenwidth > tabwidth ? 30 : 40) : 70,
            width: 8,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
          ),
        ),
        Positioned(
          left: screenwidth > tabwidth ? factor * 125 - 6.25 : 180 - 6.25,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: isNext? Colors.deepOrangeAccent : Colors.lightBlue
          ),
        ),
      ],
    );
  }
}
