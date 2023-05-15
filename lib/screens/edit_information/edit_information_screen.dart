import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'edit_information_screen_desktop.dart';

//A stateless widget for displaying edit information screen
class EditInformationScreen extends StatelessWidget {
  //Constructor
  const EditInformationScreen({Key? key}) : super(key: key);
  static const String routeName = '/edit_information';

  @override
  Widget build(BuildContext context) {
    //Routes to the respective widgets for each of the versions
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const EditInformationScreenDesktop(),
      tablet: (BuildContext context) => const EditInformationScreenDesktop(),
      desktop: (BuildContext context) => const EditInformationScreenDesktop(),
    );
  }
}