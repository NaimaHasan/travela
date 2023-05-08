import 'package:flutter/material.dart';

import '../../../common/models/destination.dart';
import '../../destination/destination_screen.dart';

class SearchResultCard extends StatelessWidget {
  const SearchResultCard({Key? key, required this.cardTextWidth, required this.destination})
      : super(key: key);
  final Destination destination;
  final double cardTextWidth;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed("${DestinationScreen.routeName}/${destination.name}");
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
                  Image.network(destination.image[0],
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
                      destination.tag,
                      style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),
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
                        destination.name,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        destination.address,
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
