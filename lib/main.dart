import 'package:flutter/material.dart';
import 'package:travela/screens/map.dart';
import 'package:travela/screens/search.dart';
import 'package:travela/screens/destination.dart';
import 'package:travela/screens/homepage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travela',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: HomePageScreen.routeName,
      routes: {
        HomePageScreen.routeName: (ctx) => const HomePageScreen(),
        SearchScreen.routeName: (ctx) => const SearchScreen(),
        MapScreen.routeName: (ctx) => const MapScreen(),
        DestinationScreen.routeName: (ctx) => const DestinationScreen(),
      },
    );
  }
}