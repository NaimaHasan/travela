import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/home/home_screen_mobile.dart';
import 'package:travela/screens/home/home_screen_desktop.dart';

class HomeScreen extends StatelessWidget {
  //Constructor
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    //Routes to the respective widgets for each of the versions
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const HomeScreenMobile(),
      tablet: (BuildContext context) => const HomeScreenMobile(),
      desktop: (BuildContext context) => const HomeScreenDesktop(),
    );
  }
}