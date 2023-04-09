import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/map/map_screen_desktop.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);
  static const String routeName = '/map';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => Container(color:Colors.blue),
      tablet: (BuildContext context) => Container(color:Colors.yellow),
      desktop: (BuildContext context) => const MapScreenDesktop(),
    );
  }
}