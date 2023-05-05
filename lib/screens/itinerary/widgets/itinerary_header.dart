import 'package:flutter/material.dart';

class ItineraryHeader extends StatelessWidget {
  const ItineraryHeader({Key? key, required this.text, this.isMiddle = false})
      : super(key: key);

  final String text;
  final bool isMiddle;

  @override
  Widget build(BuildContext context) {
    var tabwidth = 945;
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.width > tabwidth
                ? MediaQuery.of(context).size.width / tabwidth * 25
                : 37,
            child: Container(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.width > tabwidth
                      ? MediaQuery.of(context).size.width / tabwidth * 5
                      : 7,
                  horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width > tabwidth
                      ? MediaQuery.of(context).size.width / tabwidth * 11
                      : 18,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isMiddle,
          child: Positioned(
            left: MediaQuery.of(context).size.width > tabwidth
                ? MediaQuery.of(context).size.width / tabwidth * 125
                : 225,
            child: Container(
              height: MediaQuery.of(context).size.width > tabwidth
                  ? MediaQuery.of(context).size.width / tabwidth * 25
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
