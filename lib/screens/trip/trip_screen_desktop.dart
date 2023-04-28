import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travela/screens/itinerary/itinerary_screen.dart';
import 'package:travela/screens/new_trip/new_trip_screen.dart';
import 'package:travela/screens/trip/widgets/trip_grid.dart';

import '../../widgets/common/top_navigation_bar.dart';

class TripScreenDesktop extends StatelessWidget {
  const TripScreenDesktop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        child: const TopNavigationBar(
          hasSearch: false,
          hasAccount: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 250, right: 250, top: 30),
          child: Column(
            children: [
              Row(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 30),
                      child: Text(
                        'Your Trips',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(NewTripScreen.routeName);
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                          splashRadius: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TripGrid(),
              Row(
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 30),
                      child: Text(
                        'Your Group Trips',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: EdgeInsets.only(top: 30, bottom: 30),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(NewTripScreen.routeName);
                          },
                          icon: const Icon(
                            Icons.add,
                            size: 30,
                          ),
                          splashRadius: 18,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              TripGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
