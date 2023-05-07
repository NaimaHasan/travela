import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/search/search_screen_desktop.dart';
import 'package:travela/screens/search/search_screen_mobile.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key, required this.searchTerm}) : super(key: key);
  static const String routeName = '/search';
  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => SearchScreenMobile(searchTerm: searchTerm),
      tablet: (BuildContext context) => SearchScreenMobile(searchTerm: searchTerm),
      desktop: (BuildContext context) => SearchScreenDesktop(searchTerm: searchTerm),
    );
  }
}