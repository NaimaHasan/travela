import 'package:flutter/material.dart';
import 'package:travela/widgets/common/spacing.dart';

class ItineraryItem extends StatelessWidget {
  const ItineraryItem({Key? key, required this.time, required this.description, this.isStart = false, this.isEnd = false})
      : super(key: key);

  final String time;
  final String description;
  final bool isStart;
  final bool isEnd;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 35),
          child: SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                SizedBox(
                  width: 190,
                  child: Text(
                    time,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 10,
                  backgroundColor: Colors.lightBlue,
                ),
                horizontalSpaceSmall,
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                horizontalSpaceSmall,
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.edit),
                ),
                Expanded(child: Container()),
              ],
            ),
          ),
        ),
        Positioned(
          left: 231,
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
