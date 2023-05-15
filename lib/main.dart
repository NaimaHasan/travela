import 'package:firebase_auth/firebase_auth.dart';
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

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  //Constructor
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travela',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.quicksandTextTheme(Theme.of(context).textTheme),
      ),
      initialRoute: HomeScreen.routeName,
      onGenerateRoute: (settings) {
        if (settings.name!.startsWith('/itinerary/')) {
          final dynamicValue = int.parse(settings.name!.split('/').last);
          final auth = FirebaseAuth.instance;
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => auth.currentUser == null ? const LogInScreen() : ItineraryScreen(trip: dynamicValue),
            settings: auth.currentUser == null ? RouteSettings(name: "/login", arguments: settings.arguments) : settings,
            transitionDuration: Duration.zero, // Set the transition duration to zero
          );
        }
        if (settings.name!.startsWith('/search/')) {
          final dynamicValue = settings.name!.split('/').last;
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => SearchScreen(searchTerm: dynamicValue),
            settings: settings,
            transitionDuration: Duration.zero, // Set the transition duration to zero
          );
        }
        if (settings.name!.startsWith('/destination/')) {
          final dynamicValue = settings.name!.split('/').last;
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => DestinationScreen(destinationName: dynamicValue),
            settings: settings,
            transitionDuration: Duration.zero, // Set the transition duration to zero
          );
        }
        if (settings.name!.startsWith('/near-me')) {
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => const MapScreen(),
            settings: settings,
            transitionDuration: Duration.zero, // Set the transition duration to zero
          );
        }
        if (settings.name!.startsWith('/login')) {
          final auth = FirebaseAuth.instance;
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => auth.currentUser == null ? const LogInScreen() : const AccountScreen(),
            settings: auth.currentUser == null ? settings : RouteSettings(name: "/account", arguments: settings.arguments),
            transitionDuration: Duration.zero, // Set the transition duration to zero
          );
        }
        if (settings.name!.startsWith('/register')) {
          final auth = FirebaseAuth.instance;
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => auth.currentUser == null ? const RegisterScreen() : const AccountScreen(),
            settings: auth.currentUser == null ? settings : RouteSettings(name: "/account", arguments: settings.arguments),
            transitionDuration: Duration.zero, // Set the transition duration to zero
          );
        }
        if (settings.name!.startsWith('/account')) {
          final auth = FirebaseAuth.instance;
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => auth.currentUser == null ? const LogInScreen() : const AccountScreen(),
            settings: auth.currentUser == null ? RouteSettings(name: "/login", arguments: settings.arguments) : settings,
            transitionDuration: Duration.zero, // Set the transition duration to zero
          );
        }
        if (settings.name!.startsWith('/edit_information')) {
          final auth = FirebaseAuth.instance;
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => auth.currentUser == null ? const LogInScreen() : const EditInformationScreen(),
            settings: auth.currentUser == null ? RouteSettings(name: "/login", arguments: settings.arguments) : settings,
            transitionDuration: Duration.zero, // Set the transition duration to zero
          );
        }
        if (settings.name!.startsWith('/new_trip')) {
          final auth = FirebaseAuth.instance;
          return PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => auth.currentUser == null ? const LogInScreen() : const NewTripScreen(),
            settings: auth.currentUser == null ? RouteSettings(name: "/login", arguments: settings.arguments) : settings,
            transitionDuration: Duration.zero, // Set the transition duration to zero
          );
        }
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) => const HomeScreen(),
          settings: settings,
          transitionDuration: Duration.zero, // Set the transition duration to zero
        );
      },
    );
  }
}