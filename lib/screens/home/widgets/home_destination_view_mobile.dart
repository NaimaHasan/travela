import 'package:flutter/material.dart';
import 'package:travela/widgets/common/bottom_bar.dart';

import '../../../common/api/home_destination_controller.dart';
import '../../../common/enums.dart';
import '../../../common/models/home_destination.dart';
import '../../../widgets/common/pill_button.dart';
import '../../../widgets/common/search_box.dart';
import '../../../widgets/common/spacing.dart';
import 'home_carousel_mobile.dart';

//A stateful widget for home destination view mobile
class HomeDestinationViewMobile extends StatefulWidget {
  //Constructor
  const HomeDestinationViewMobile({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeDestinationViewMobileState createState() =>
      _HomeDestinationViewMobileState();
}

class _HomeDestinationViewMobileState extends State<HomeDestinationViewMobile> {
  final ValueNotifier<Future<List<HomeDestination?>>> futureValueNotifier =
      ValueNotifier(HomeDestinationController.getHomeHotDestinations());
  final ValueNotifier<Future<List<HomeDestination?>>> futureValueNotifierLOTD =
      ValueNotifier(HomeDestinationController.getLocationOfTheDay());
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
            //Pill button for filters
            //If filters are selected color of the buttons will be respectively set

            //Pill button for destination
            PillButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              onPress: () {
                //if the pill button is pressed and filter was not previously set to destination, filter is set to destination
                //if set, carousels will then only show destinations
                //else will show all types of places
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
                  ? Colors.black87
                  : Colors.white,
              child: Text(
                "Destinations",
                style: TextStyle(
                    color: filterName == FilterName.Destination
                        ? Colors.white
                        : Colors.black,
                    fontSize: 12),
              ),
            ),
            horizontalSpaceSmall,

            //Pill button for hotel
            PillButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              onPress: () {
                //if the pill button is pressed and filter was not previously set to hotel, filter is set to hotel
                //if set, carousels will then only show hotels
                //else will show all types of places
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
                  ? Colors.black87
                  : Colors.white,
              child: Text(
                "Hotels",
                style: TextStyle(
                    color: filterName == FilterName.Hotel
                        ? Colors.white
                        : Colors.black,
                    fontSize: 12),
              ),
            ),
            horizontalSpaceSmall,

            //Pill button for restaurant
            PillButton(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              onPress: () {
                //if the pill button is pressed and filter was not previously set to restaurant, filter is set to restaurant
                //if set, carousels will then only show restaurants
                //else will show all types of places
                if (filterName != FilterName.Restaurant) {
                  setState(() {
                    futureValueNotifier.value =
                        HomeDestinationController.getHomeRestaurants();
                    futureValueNotifierLOTD.value = HomeDestinationController
                        .getLocationOfTheDayRestaurants();
                    filterName = FilterName.Restaurant;
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
              color: filterName == FilterName.Restaurant
                  ? Colors.black87
                  : Colors.white,
              child: Text(
                "Restaurants",
                style: TextStyle(
                    color: filterName == FilterName.Restaurant
                        ? Colors.white
                        : Colors.black87,
                    fontSize: 12),
              ),
            ),
          ],
        ),
        verticalSpaceSmall,
        //Carousel for hot destination
        const Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: EdgeInsets.only(left: 20),
            child: Text(
              "Hot Destinations",
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
        ),
        verticalSpaceSmall,
        HomeCarouselMobile(
            isLOTD: false, futureValueNotifier: futureValueNotifier),
        verticalSpaceMedium,
        //Carousel for location of the day
        HomeCarouselMobile(
            isLOTD: true, futureValueNotifier: futureValueNotifierLOTD),
        verticalSpaceMedium,
        const BottomBar(),
      ],
    );
  }
}
