import 'dart:io';

import 'package:flutter/material.dart';

class ItineraryHeader extends StatelessWidget {
  const ItineraryHeader({Key? key, required this.text, this.isMiddle = false})
      : super(key: key);

  final String text;
  final bool isMiddle;

  @override
  Widget build(BuildContext context) {
    var tabwidth = 945;
    var screenwidth = MediaQuery.of(context).size.width;
    var factor =  (screenwidth / tabwidth) * 0.8;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: double.infinity,
            height: screenwidth > tabwidth
                ? 30
                : 37,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: screenwidth > tabwidth
                      ? factor * 5
                      : 7,
                  horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: screenwidth > tabwidth
                      ? 16
                      : 18,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isMiddle,
          child: Positioned(
            left: screenwidth > tabwidth
                ? factor * 125
                : 225,
            child: Container(
              height: screenwidth > tabwidth
                  ?  factor * 28
                  : 37,
              width: 8,
              decoration: BoxDecoration(
                color: Colors.lightBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
