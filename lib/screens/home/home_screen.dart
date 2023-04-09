import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/home/home_screen_desktop.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => Container(color:Colors.blue),
      tablet: (BuildContext context) => Container(color:Colors.yellow),
      desktop: (BuildContext context) => const HomeScreenDesktop(),
    );
  }
}