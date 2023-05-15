
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
  // ignore: library_private_types_in_public_api
  _HomeDestinationViewState createState() => _HomeDestinationViewState();
}

class _HomeDestinationViewState extends State<HomeDestinationView> {
  final ValueNotifier<Future<List<HomeDestination?>>> futureValueNotifier =
      ValueNotifier(HomeDestinationController.getHomeHotDestinations());
  final ValueNotifier<Future<List<HomeDestination?>>> futureValueNotifierLOTD =
      ValueNotifier(HomeDestinationController.getLocationOfTheDay());
  FilterName filterName = FilterName.None;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            PillButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              onPress: () {
                if (filterName != FilterName.Destination) {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeDestinations();
                    futureValueNotifierLOTD.value = HomeDestinationController
                        .getLocationOfTheDayDestinations();
                    filterName = FilterName.Destination;
                  });
                } else {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeHotDestinations();
                    futureValueNotifierLOTD.value =
                        HomeDestinationController.getLocationOfTheDay();
                    filterName = FilterName.None;
                  });
                }
              },
              color: filterName == FilterName.Destination
                  ? Colors.lightBlueAccent
                  : Colors.white,
              child: const Text(
                "Destinations",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ),
            horizontalSpaceSmall,
            PillButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              onPress: () {
                if (filterName != FilterName.Hotel) {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeHotels();
                    futureValueNotifierLOTD.value =
                        HomeDestinationController.getLocationOfTheDayHotels();
                    filterName = FilterName.Hotel;
                  });
                } else {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeHotDestinations();
                    futureValueNotifierLOTD.value =
                        HomeDestinationController.getLocationOfTheDay();
                    filterName = FilterName.None;
                  });
                }
              },
              color: filterName == FilterName.Hotel
                  ? Colors.lightBlueAccent
                  : Colors.white,
              child: const Text(
                "Hotels",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ),
            horizontalSpaceSmall,
            PillButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 25),
              onPress: () {
                if (filterName != FilterName.Resturant) {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeRestaurants();
                    futureValueNotifierLOTD.value = HomeDestinationController
                        .getLocationOfTheDayRestaurants();
                    filterName = FilterName.Resturant;
                  });
                } else {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeHotDestinations();
                    futureValueNotifierLOTD.value =
                        HomeDestinationController.getLocationOfTheDay();
                    filterName = FilterName.None;
                  });
                }
              },
              color: filterName == FilterName.Resturant
                  ? Colors.lightBlueAccent
                  : Colors.white,
              child: const Text(
                "Restaurants",
                style: TextStyle(color: Colors.black, fontSize: 13),
              ),
            ),
          ],
        ),
        verticalSpaceSmall,
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: marginHorizontal),
            child: const Text(
              "Hot Destinations",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
          child: HomeCarousel(
            isLOTD: false,
            futureValueNotifier: futureValueNotifier,
          ),
        ),
        verticalSpaceMedium,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: marginHorizontal),
          child: HomeCarousel(
            isLOTD: true,
            futureValueNotifier: futureValueNotifierLOTD,
          ),
        ),
      ],
    );
  }
}
