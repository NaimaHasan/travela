import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../common/api/homeDestinationController.dart';
import '../../../common/enums.dart';
import '../../../common/models/homeDestination.dart';
import '../../../widgets/common/pill_button.dart';
import '../../../widgets/common/spacing.dart';
import 'home_carousel.dart';

class HomeDestinationView extends StatefulWidget {
  const HomeDestinationView({Key? key}) : super(key: key);

  @override
  _HomeDestinationViewState createState() => _HomeDestinationViewState();
}

class _HomeDestinationViewState extends State<HomeDestinationView> {
  final ValueNotifier<Future<List<HomeDestination?>>> futureValueNotifier =
      ValueNotifier(HomeDestinationController.getHomeHotDestinations());
  FilterName filterName = FilterName.None;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PillButton(
              child: Text(
                "Destinations",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              onPress: () {
                if (filterName != FilterName.Destination) {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeDestinations();
                    filterName = FilterName.Destination;
                  });
                } else {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeHotDestinations();
                    filterName = FilterName.None;
                  });
                }
              },
              color: filterName == FilterName.Destination
                  ? Colors.lightBlueAccent
                  : Colors.white,
            ),
            horizontalSpaceSmall,
            PillButton(
              child: Text(
                "Hotels",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              onPress: () {
                if (filterName != FilterName.Hotel) {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeHotels();
                    filterName = FilterName.Hotel;
                  });
                } else {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeHotDestinations();
                    filterName = FilterName.None;
                  });
                }
              },
              color: filterName == FilterName.Hotel
                  ? Colors.lightBlueAccent
                  : Colors.white,
            ),
            horizontalSpaceSmall,
            PillButton(
              child: Text(
                "Restaurants",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              onPress: () {
                if (filterName != FilterName.Resturant) {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeRestaurants();
                    filterName = FilterName.Resturant;
                  });
                } else {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeHotDestinations();
                    filterName = FilterName.None;
                  });
                }
              },
              color: filterName == FilterName.Resturant
                  ? Colors.lightBlueAccent
                  : Colors.white,
            ),
          ],
        ),
        verticalSpaceSmall,
        Align(
          child: Padding(
            padding: EdgeInsets.only(left: marginHorizontal),
            child: Text(
              "Hot Destinations",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        verticalSpaceSmall,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
          child: HomeCarousel(
              name: 'Hot destination',
              futureValueNotifier: futureValueNotifier),
        ),
        verticalSpaceMedium,
        Align(
          child: Padding(
            padding: EdgeInsets.only(left: marginHorizontal),
            child: Text(
              "Location of the Day: Venice",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          alignment: Alignment.centerLeft,
        ),
        verticalSpaceSmall,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
          child: HomeCarousel(
            name: 'Location of the day',
            futureValueNotifier: futureValueNotifier,
          ),
        ),
      ],
    );
  }
}
