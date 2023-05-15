import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/destination/destination_screen_desktop.dart';
import 'package:travela/screens/destination/destination_screen_mobile.dart';

class DestinationScreen extends StatelessWidget {
  //Constructor
  const DestinationScreen({Key? key, required this.destinationName}) : super(key: key);
  static const String routeName = '/destination';

  final String destinationName;

  @override
  Widget build(BuildContext context) {
    //Routes to the respective widgets for each of the versions
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => DestinationScreenMobile(destinationName: destinationName),
      tablet: (BuildContext context) => DestinationScreenMobile(destinationName: destinationName),
      desktop: (BuildContext context) => DestinationScreenDesktop(destinationName: destinationName),
    );
  }
}
