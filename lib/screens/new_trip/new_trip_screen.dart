import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'new_trip_screen_desktop.dart';


class NewTripScreen extends StatelessWidget {
  const NewTripScreen({Key? key}) : super(key: key);
  static const String routeName = '/new_trip';

  @override
  Widget build(BuildContext context) {
    String? name = ModalRoute.of(context)!.settings.arguments as String?;
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => NewTripScreenDesktop(initialName: name),
      tablet: (BuildContext context) => NewTripScreenDesktop(initialName: name),
      desktop: (BuildContext context) => NewTripScreenDesktop(initialName: name),
    );
  }
}