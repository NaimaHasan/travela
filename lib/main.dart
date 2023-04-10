import 'package:flutter/material.dart';
import 'package:travela/screens/account/account_screen.dart';
import 'package:travela/screens/edit_information/edit_information_screen.dart';
import 'package:travela/screens/itinerary/itinerary_screen.dart';
import 'package:travela/screens/login/login_screen.dart';
import 'package:travela/screens/map/map_screen.dart';
import 'package:travela/screens/new_trip/new_trip_screen.dart';
import 'package:travela/screens/register/register_screen.dart';
import 'package:travela/screens/search/search_screen.dart';
import 'package:travela/screens/destination/destination_screen.dart';
import 'package:travela/screens/home/home_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:travela/screens/trip/trip_screen.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: HomeScreen.routeName,
      routes: {
        HomeScreen.routeName: (ctx) => const HomeScreen(),
        SearchScreen.routeName: (ctx) => const SearchScreen(),
        MapScreen.routeName: (ctx) => const MapScreen(),
        DestinationScreen.routeName: (ctx) => const DestinationScreen(),
        LogInScreen.routeName: (ctx) => const LogInScreen(),
        RegisterScreen.routeName: (ctx) => const RegisterScreen(),
        AccountScreen.routeName: (ctx) => const AccountScreen(),
        EditInformationScreen.routeName: (ctx) => const EditInformationScreen(),
        NewTripScreen.routeName: (ctx) => const NewTripScreen(),
        ItineraryScreen.routeName: (ctx) => const ItineraryScreen(),
        TripScreen.routeName: (ctx) => const TripScreen(),
      },
    );
  }
}