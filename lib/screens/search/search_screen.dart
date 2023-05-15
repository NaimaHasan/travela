import 'package:flutter/material.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:travela/screens/search/search_screen_desktop.dart';
import 'package:travela/screens/search/search_screen_mobile.dart';

class SearchScreen extends StatelessWidget {
  //Constructor
  const SearchScreen({Key? key, required this.searchTerm}) : super(key: key);
  static const String routeName = '/search';
  final String searchTerm;

  @override
  Widget build(BuildContext context) {
    //Routes to the respective widgets for each of the versions
    return ScreenTypeLayout.builder(
      mobile: (BuildContext context) => SearchScreenMobile(searchTerm: searchTerm),
      tablet: (BuildContext context) => SearchScreenMobile(searchTerm: searchTerm),
      desktop: (BuildContext context) => SearchScreenDesktop(searchTerm: searchTerm),
    );
  }
}