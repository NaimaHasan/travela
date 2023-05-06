import 'package:flutter/material.dart';
import 'package:travela/widgets/common/spacing.dart';

class ItineraryItem extends StatelessWidget {
  const ItineraryItem(
      {Key? key,
      required this.time,
      required this.description,
      this.isStart = false,
      this.isEnd = false})
      : super(key: key);

  final String time;
  final String description;
  final bool isStart;
  final bool isEnd;

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
                      ? factor * 45
                      : screenwidth / 450 * 60,
                ),
                SizedBox(
                  width: screenwidth > tabwidth
                      ? factor * 100
                      : screenwidth / 450 * 90,
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
                  onPressed: () {},
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
          left: screenwidth > tabwidth ? factor * 125 - 6.25 : 225 - 6.25,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.lightBlue,
          ),
        ),
        Positioned(
          left: screenwidth > tabwidth ? factor * 125 : 225,
          top: isStart ? 30 : 0,
          child: Container(
            height: isStart || isEnd ? (screenwidth > tabwidth ? 30 : 40)  : 70,
            width: 8,
            decoration: BoxDecoration(
              color: Colors.lightBlue,
            ),
          ),
        )
      ],
    );
  }
}
