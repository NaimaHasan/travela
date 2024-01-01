import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../common/models/destination.dart';
import '../../destination/destination_screen.dart';

//A stateless widget for displaying search result card
class SearchResultCard extends StatelessWidget {
  //Constructor
  const SearchResultCard(
      {Key? key, required this.cardTextWidth, required this.destination})
      : super(key: key);
  final Destination destination;
  final double cardTextWidth;
  @override
  Widget build(BuildContext context) {
    //When the search result card is tapped, the screen routes to the corresponding destination screen
    return InkWell(
      onTap: () {
        Navigator.of(context)
            .pushNamed("${DestinationScreen.routeName}/${destination.name}");
      },
      child: Card(
        elevation: 2,
        borderOnForeground: true,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              //Displays the destination image with a gradient on top so the destination tag is properly visible
              Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: destination.image[0],
                    fit: BoxFit.cover,
                    height: 150.0,
                    width: 210,
                  ),
                  //Displays the gradient on top of the image
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
                  //Displays the destination tag
                  Positioned(
                    left: 10,
                    bottom: 10,
                    child: Text(
                      destination.tag,
                      style: const TextStyle(
                          fontSize: 15,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  height: 140,
                  width: cardTextWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //Displays the destination name
                      Text(
                        destination.name,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      //Displays the destination address
                      Text(
                        destination.address,
                        style: const TextStyle(fontSize: 14),
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
