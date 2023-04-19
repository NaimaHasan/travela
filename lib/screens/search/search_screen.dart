import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/search/search_screen_desktop.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);
  static const String routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => const SearchScreenDesktop(),
      tablet: (BuildContext context) => const SearchScreenDesktop(),
      desktop: (BuildContext context) => const SearchScreenDesktop(),
    );
  }
}