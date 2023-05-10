import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../common/api/homeDestinationController.dart';
import '../../../common/enums.dart';
import '../../../common/models/homeDestination.dart';
import '../../destination/destination_screen.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
];

class HomeCarousel extends StatefulWidget {
  const HomeCarousel({Key? key, required this.name, required this.filterName})
      : super(key: key);
  final String name;
  final FilterName filterName;
  @override
  _HomeCarouselState createState() => _HomeCarouselState();
}

class _HomeCarouselState extends State<HomeCarousel> {
  late Future<List<HomeDestination?>> _future;

  void setFutures() {
    switch (widget.filterName) {
      case FilterName.Destination:
        _future = HomeDestinationController.getHomeDestinations();
        break;
      case FilterName.Hotel:
        _future = HomeDestinationController.getHomeHotels();
        break;
      case FilterName.Resturant:
        _future = HomeDestinationController.getHomeRestaurants();
        break;
      case FilterName.None:
        _future = HomeDestinationController.getHomeHotDestinations();
        break;
    }
  }

  @override
  void initState() {
    setFutures();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    setFutures();
    super.didChangeDependencies();
  }

  @override
  void didUpdateWidget(covariant HomeCarousel oldWidget) {
    setFutures();
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (ctx, futureResult) {
        if (futureResult.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!futureResult.hasData || futureResult.data == null) {
          return Center(
            child: Text("No destination available"),
          );
        }
        return CarouselSlider(
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
                  margin: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(DestinationScreen.routeName);
                      },
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
                                  child: Image.network(item!.image,
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
                          Positioned(
                            bottom: 15,
                            left: 15,
                            child: Text(
                              item!.name,
                              style:
                                  TextStyle(fontSize: 22, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        );
      },
    );
  }
}
