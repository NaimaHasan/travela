import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../common/api/homeDestinationController.dart';
import '../../../common/enums.dart';
import '../../../common/models/homeDestination.dart';
import '../../../widgets/common/pill_button.dart';
import '../../../widgets/common/search_box.dart';
import '../../../widgets/common/spacing.dart';
import 'home_carousel.dart';
import 'home_carousel_mobile.dart';

class HomeDestinationViewMobile extends StatefulWidget {
  const HomeDestinationViewMobile({Key? key}) : super(key: key);

  @override
  _HomeDestinationViewMobileState createState() =>
      _HomeDestinationViewMobileState();
}

class _HomeDestinationViewMobileState extends State<HomeDestinationViewMobile> {
  final ValueNotifier<Future<List<HomeDestination?>>> futureValueNotifier =
      ValueNotifier(HomeDestinationController.getHomeHotDestinations());
  FilterName filterName = FilterName.None;

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Column(
      children: [
        SearchBox(width: screenSize.width - 2 * marginHorizontalMobile),
        verticalSpaceSmall,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PillButton(
              child: Text(
                "Destinations",
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
                style: TextStyle(color: Colors.black, fontSize: 12),
              ),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
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
            padding: EdgeInsets.only(left: 20),
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
        HomeCarouselMobile(
            name: 'Hot Destinations', futureValueNotifier: futureValueNotifier),
        verticalSpaceMedium,
        Align(
          child: Padding(
            padding: EdgeInsets.only(left: 20),
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
        HomeCarouselMobile(
            name: 'Location of the day',
            futureValueNotifier: futureValueNotifier),
      ],
    );
  }
}