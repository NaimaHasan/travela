

import 'package:flutter/material.dart';

//A stateless widget for displaying the itinerary header
class ItineraryHeader extends StatelessWidget {
  //Constructor
  const ItineraryHeader({Key? key, required this.text, this.isMiddle = false})
      : super(key: key);

  final String text;
  final bool isMiddle;

  @override
  Widget build(BuildContext context) {
    //Variable for tab width limit
    var tabWidth = 945;
    //Variable for screen size
    var screenWidth = MediaQuery.of(context).size.width;
    //Scaling factor for responsiveness
    var factor =  (screenWidth / tabWidth) * 0.8;

    return Stack(
      alignment: Alignment.center,
      children: [
        //Displays the grey bar in the itinerary header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: double.infinity,
            height: 37,
            child: Container(
              padding: const EdgeInsets.symmetric(
                  vertical: 7,
                  horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: screenWidth > tabWidth
                      ? 16
                      : 18,
                ),
              ),
            ),
          ),
        ),
        //Displays the blue line in the itinerary header
        Visibility(
          visible: isMiddle,
          child: Positioned(
            left: screenWidth > tabWidth
                ? factor * 125
                : 180,
            child: Container(
              height: 37,
              width: 8,
              decoration: const BoxDecoration(
                color: Colors.lightBlue,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
