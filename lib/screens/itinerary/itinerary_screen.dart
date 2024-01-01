import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/itinerary/itinerary_screen_mobile.dart';

import 'itinerary_screen_desktop.dart';

//A stateless widget for displaying Itinerary screen
class ItineraryScreen extends StatelessWidget {
  //Constructor
  const ItineraryScreen({Key? key, required this.trip}) : super(key: key);
  static const String routeName = '/itinerary';

  final int trip;

  @override
  Widget build(BuildContext context) {
    //Routes to the respective widgets for each of the versions
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => ItineraryScreenMobile(trip: trip),
      tablet: (BuildContext context) => ItineraryScreenMobile(trip: trip),
      desktop: (BuildContext context) => ItineraryScreenDesktop(trip: trip),
    );
  }
}