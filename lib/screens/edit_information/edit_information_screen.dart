import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'edit_information_screen_desktop.dart';

class EditInformationScreen extends StatelessWidget {
  const EditInformationScreen({Key? key}) : super(key: key);
  static const String routeName = '/edit_information';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const EditInformationScreenDesktop(),
      tablet: (BuildContext context) => const EditInformationScreenDesktop(),
      desktop: (BuildContext context) => const EditInformationScreenDesktop(),
    );
  }
}