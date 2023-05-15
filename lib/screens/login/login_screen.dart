import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';

import 'login_screen_desktop.dart';


class LogInScreen extends StatelessWidget {
  //Constructor
  const LogInScreen({Key? key}) : super(key: key);
  static const String routeName = '/login';

  @override
  Widget build(BuildContext context) {
    //Routes to the respective widgets for each of the versions
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const LogInScreenDesktop(),
      tablet: (BuildContext context) => const LogInScreenDesktop(),
      desktop: (BuildContext context) => const LogInScreenDesktop(),
    );
  }
}