import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/map/map_screen_desktop.dart';

//A stateless widget for displaying map screen
class MapScreen extends StatelessWidget {
  //Constructor
  const MapScreen({Key? key}) : super(key: key);
  static const String routeName = '/near-me';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      //Routes to the respective widgets for each of the versions
      mobile: (BuildContext context) => const MapScreenDesktop(),
      tablet: (BuildContext context) => const MapScreenDesktop(),
      desktop: (BuildContext context) => const MapScreenDesktop(),
    );
  }
}