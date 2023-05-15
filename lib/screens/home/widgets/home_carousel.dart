import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../common/models/home_destination.dart';
import '../../../widgets/common/spacing.dart';
import '../../destination/destination_screen.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

//A stateful widget for home carousel desktop
class HomeCarousel extends StatefulWidget {
  //Constructor
  const HomeCarousel(
      {Key? key, required this.futureValueNotifier, required this.isLOTD})
      : super(key: key);
  final ValueNotifier<Future<List<HomeDestination?>>> futureValueNotifier;
  final bool isLOTD;
  @override
  // ignore: library_private_types_in_public_api
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.futureValueNotifier,
      builder: (context, future, child) {
        //Future builder for home carousel data
        //Checks the relevant conditions and displays messages on screen accordingly
        return FutureBuilder(
          future: future,
          builder: (ctx, futureResult) {
            if (futureResult.connectionState == ConnectionState.waiting) {
              return Column(
                children: [
                  //If the data is for location of the day, displays the text location of the day
                  Visibility(
                    visible: widget.isLOTD,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Location of the Day",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  //Displays the circular progress indicator if connection state is waiting
                  const SizedBox(
                    height: 400,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                ],
              );
            }
            //If there is no data shows text that no destinations are available
            if (!futureResult.hasData ||
                futureResult.data == null ||
                futureResult.data!.isEmpty) {
              return Column(
                children: [
                  Visibility(
                    visible: widget.isLOTD,
                    child: const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Location of the Day",
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                    ),
                  ),
                  verticalSpaceSmall,
                  const SizedBox(
                    height: 400,
                    child: Center(
                      child: Text("No destinations available"),
                    ),
                  ),
                ],
              );
            }
            //If there is data displays location of the day
            return Column(
              children: [
                Visibility(
                  visible: widget.isLOTD,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Location of the Day: ${futureResult.data![0]!.location}",
                      style: const TextStyle(
                        fontSize: 24,
                      ),
                    ),
                  ),
                ),
                verticalSpaceSmall,
                //Carousel slider for home destination images
                SizedBox(
                  height: 400,
                  child: CarouselSlider(
                    options: CarouselOptions(
                      autoPlay: false,
                      enlargeCenterPage: true,
                      enlargeStrategy: CenterPageEnlargeStrategy.height,
                      enlargeFactor: 0.1,
                      viewportFraction: 0.335,
                      height: 400,
                      initialPage: 5,
                    ),
                    items: futureResult.data!
                        .map(
                          (item) => Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5.0)),
                              //if the destination is tapped, screen routes to the destination screen for the respective destination
                              child: InkWell(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      "${DestinationScreen.routeName}/${item.name}");
                                },
                                //Displays the image and adds a gradient to the image so that the name is visible for all kinds of images
                                child: Stack(
                                  children: [
                                    LayoutBuilder(
                                      builder: (BuildContext context,
                                          BoxConstraints constraints) {
                                        return FittedBox(
                                          fit: BoxFit.cover,
                                          child: SizedBox(
                                            width: constraints.maxWidth,
                                            height: constraints.maxHeight,
                                            child: CachedNetworkImage(
                                                imageUrl: item!.image,
                                                fit: BoxFit.cover),
                                          ),
                                        );
                                      },
                                    ),
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
                                      child: Container(),
                                    ),
                                    //Displays the carousel destination name
                                    Positioned(
                                      bottom: 15,
                                      left: 15,
                                      child: Text(
                                        item!.name,
                                        style: const TextStyle(
                                            fontSize: 22, color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
