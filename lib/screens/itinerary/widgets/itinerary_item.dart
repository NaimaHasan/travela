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
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              vertical: MediaQuery.of(context).size.width > tabwidth
                  ? MediaQuery.of(context).size.width / tabwidth * 5
                  : 15,
              horizontal: 25),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width > tabwidth
                      ? MediaQuery.of(context).size.width / tabwidth * 115
                      : 190,
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width > tabwidth
                          ? MediaQuery.of(context).size.width / tabwidth * 11
                          : 16,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width > tabwidth
                      ? MediaQuery.of(context).size.width / tabwidth * 45
                      : MediaQuery.of(context).size.width / 450 * 60,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width > tabwidth
                      ? MediaQuery.of(context).size.width / tabwidth * 80
                      : MediaQuery.of(context).size.width / 450 * 90,
                  child: Text(
                    description,
                    style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width > tabwidth
                          ? MediaQuery.of(context).size.width / tabwidth * 11
                          : 16,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 5),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                  iconSize: MediaQuery.of(context).size.width > tabwidth
                      ? MediaQuery.of(context).size.width / tabwidth * 14
                      : 18,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width > tabwidth
              ? MediaQuery.of(context).size.width / tabwidth * 125 - 6.25
              : 225 - 6.25,
          child: CircleAvatar(
            radius: 10,
            backgroundColor: Colors.lightBlue,
          ),
        ),
        Positioned(
          left: MediaQuery.of(context).size.width > tabwidth
              ? MediaQuery.of(context).size.width / tabwidth * 125
              : 225,
          top: isStart ? 35 : 0,
          child: Container(
            height: isStart || isEnd ? 35 : 70,
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
