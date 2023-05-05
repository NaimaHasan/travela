import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/itinerary/itinerary_screen_mobile.dart';

import '../../common/models/trip.dart';
import 'itinerary_screen_desktop.dart';


class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({Key? key, required this.trip}) : super(key: key);
  static const String routeName = '/itinerary';

  final int trip;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => ItineraryScreenMobile(trip: trip),
      tablet: (BuildContext context) => ItineraryScreenMobile(trip: trip),
      desktop: (BuildContext context) => ItineraryScreenDesktop(trip: trip),
    );
  }
}