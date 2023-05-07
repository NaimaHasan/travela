import 'package:flutter/material.dart';

import '../../destination/destination_screen.dart';

class SearchResultCard extends StatelessWidget {
  SearchResultCard({Key? key, required this.image, required this.cardTextWidth})
      : super(key: key);
  String image;
  double cardTextWidth;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(DestinationScreen.routeName);
      },
      child: Card(
        elevation: 2,
        borderOnForeground: true,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Stack(
                children: [
                  Image.network(image,
                      fit: BoxFit.cover, height: 150.0, width: 210),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color.fromARGB(50, 0, 0, 0),
                          Color.fromARGB(0, 0, 0, 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Text(
                      'Hotel',
                      style: TextStyle(fontSize: 15, color: Colors.white),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20),
                child: Container(
                  height: 140,
                  width: cardTextWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dhakakakaka',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Dhakakaka asdugfwoua sadkjabsdoa xsOUxasou  saxba saduosgf asdjb dlsobd dalih subcka',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
