import 'package:flutter/material.dart';
import 'package:travela/screens/account/account_screen.dart';
import 'package:travela/screens/edit_information/edit_information_screen.dart';
import 'package:travela/screens/login/login_screen.dart';
import 'package:travela/screens/map/map_screen.dart';
import 'package:travela/screens/register/register_screen.dart';
import 'package:travela/screens/search/search_screen.dart';
import 'package:travela/screens/destination/destination_screen.dart';
import 'package:travela/screens/home/home_screen.dart';
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
      },
    );
  }
}