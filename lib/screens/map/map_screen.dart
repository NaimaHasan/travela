import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/map/map_screen_desktop.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const String routeName = '/map';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const MapScreenDesktop(),
      tablet: (BuildContext context) => const MapScreenDesktop(),
      desktop: (BuildContext context) => const MapScreenDesktop(),
    );
  }
}