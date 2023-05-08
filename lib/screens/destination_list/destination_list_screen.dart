import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'destination_list_screen_desktop.dart';

class DestinationListScreen extends StatelessWidget {
  const DestinationListScreen({Key? key}) : super(key: key);
  static const String routeName = '/destinationlist';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => DestinationListScreenDesktop(),
      tablet: (BuildContext context) => DestinationListScreenDesktop(),
      desktop: (BuildContext context) => DestinationListScreenDesktop(),
    );
  }
}
