import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/trip/trip_screen_desktop.dart';



class TripScreen extends StatelessWidget {
  const TripScreen({Key? key}) : super(key: key);
  static const String routeName = '/trip';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const TripScreenDesktop(),
      tablet: (BuildContext context) => const TripScreenDesktop(),
      desktop: (BuildContext context) => const TripScreenDesktop(),
    );
  }
}