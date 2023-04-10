import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travela/screens/itinerary/itinerary_screen.dart';
import 'package:travela/screens/new_trip/new_trip_screen.dart';

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
                        padding:
                            EdgeInsets.only(top: 30, bottom: 30),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(NewTripScreen.routeName);
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
              Container(
                height: 500,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 80,
                    mainAxisSpacing: 50,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return Card(
                      elevation: 5,
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Container(
                              height: 160,
                              width: 160,
                              color: Colors.tealAccent,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Padding(
                                    padding:
                                        EdgeInsets.only(top: 25, bottom: 10),
                                    child: Text(
                                      'Madeira Trip',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(bottom: 45),
                                    child: Text(
                                      '23rd March - 28th March',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.share),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
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
                        padding:
                            EdgeInsets.only(top: 30, bottom: 30),
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pushNamed(NewTripScreen.routeName);
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
              Container(
                height: 500,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 80,
                    mainAxisSpacing: 50,
                    childAspectRatio: 2.2,
                  ),
                  itemCount: 5,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).pushNamed(ItineraryScreen.routeName);
                      },
                      child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Container(
                                height: 160,
                                width: 160,
                                color: Colors.tealAccent,
                              ),
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 15),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Padding(
                                      padding:
                                      EdgeInsets.only(top: 25, bottom: 10),
                                      child: Text(
                                        'Madeira Trip',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(bottom: 45),
                                      child: Text(
                                        '23rd March - 28th March',
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.share),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
