import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/itinerary/itinerary_screen_mobile.dart';

import 'itinerary_screen_desktop.dart';


class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({Key? key}) : super(key: key);
  static const String routeName = '/itinerary';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const ItineraryScreenMobile(),
      tablet: (BuildContext context) => const ItineraryScreenMobile(),
      desktop: (BuildContext context) => const ItineraryScreenDesktop(),
    );
  }
}