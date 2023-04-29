import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'new_trip_screen_desktop.dart';


class NewTripScreen extends StatelessWidget {
  const NewTripScreen({Key? key}) : super(key: key);
  static const String routeName = '/new_trip';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => NewTripScreenDesktop(),
      tablet: (BuildContext context) => NewTripScreenDesktop(),
      desktop: (BuildContext context) => NewTripScreenDesktop(),
    );
  }
}