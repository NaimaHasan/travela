import 'package:flutter/material.dart';

class ItineraryHeader extends StatelessWidget {
  const ItineraryHeader({Key? key, required this.text, this.isMiddle = false})
      : super(key: key);

  final String text;
  final bool isMiddle;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: SizedBox(
            width: double.infinity,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 7, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: isMiddle,
          child: Positioned(
            left: 231,
            child: Container(
              height: 37,
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
