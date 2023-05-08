import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/destination/destination_screen_desktop.dart';
import 'package:travela/screens/destination/destination_screen_mobile.dart';

class DestinationScreen extends StatelessWidget {
  const DestinationScreen({Key? key, required this.destination}) : super(key: key);
  static const String routeName = '/destination';

  final String destination;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const DestinationScreenMobile(),
      tablet: (BuildContext context) => const DestinationScreenMobile(),
      desktop: (BuildContext context) => const DestinationScreenDesktop(),
    );
  }
}
