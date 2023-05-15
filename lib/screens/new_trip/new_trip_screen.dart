import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'new_trip_screen_desktop.dart';

//A stateless widget for displaying the new trip screen
class NewTripScreen extends StatelessWidget {
  //Constructor
  const NewTripScreen({Key? key}) : super(key: key);
  static const String routeName = '/new_trip';

  @override
  Widget build(BuildContext context) {
    String? name, address;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      name = (ModalRoute.of(context)!.settings.arguments as List<String>)[0];
      address = (ModalRoute.of(context)!.settings.arguments as List<String>)[1];
    }
    //Routes to the respective widgets for each of the versions
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => NewTripScreenDesktop(initialName: name, initialAddress: address),
      tablet: (BuildContext context) => NewTripScreenDesktop(initialName: name, initialAddress: address),
      desktop: (BuildContext context) =>
          NewTripScreenDesktop(initialName: name),
    );
  }
}
