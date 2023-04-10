import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'itinerary_screen_desktop.dart';


class ItineraryScreen extends StatelessWidget {
  const ItineraryScreen({Key? key}) : super(key: key);
  static const String routeName = '/itinerary';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const ItineraryScreenDesktop(),
      tablet: (BuildContext context) => const ItineraryScreenDesktop(),
      desktop: (BuildContext context) => const ItineraryScreenDesktop(),
    );
  }
}