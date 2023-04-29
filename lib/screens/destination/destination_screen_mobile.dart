
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:travela/screens/destination/widgets/destination_image.dart';
import 'package:travela/screens/destination/widgets/destination_nearby.dart';

import '../../widgets/common/top_navigation_bar.dart';


class DestinationScreenMobile extends StatelessWidget {
  const DestinationScreenMobile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 80),
        child: const TopNavigationBar(
          hasSearch: false,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DestinationImage(),
            const Padding(
              padding:
              EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 30),
              child: Text(
                'Description',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'daoiholwfh awdbwak ldbqlwd awdsn;owa bfwoabfiwua lhfqiwsba ADHAWJD KBAWHIBD DABNAJKSBF JAKBFJA',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 15, top: 30),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.location_on_outlined,
                    color: Colors.yellow[700],
                  )
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.width / 2,
              child: Image.asset(
                'lib/assets/dummy.jpg',
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding:
              EdgeInsets.only(left: 15, right: 15, bottom: 10, top: 30),
              child: Text(
                'Things to do',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'daoiholwfh awdbwak ldbqlwd awdsn;owa bfwoabfiwua lhfqiwsba ADHAWJD KBAWHIBD DABNAJKSBF JAKBFJA',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10, top: 40),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Nearby Hotels',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.maps_home_work_outlined,
                    color: Colors.yellow[700],
                  )
                ],
              ),
            ),
            const DestinationNearbyPlaces(),
            Padding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 10, top: 40),
              child: Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Nearby Restaurants',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ),
                  Icon(
                    Icons.restaurant_menu,
                    color: Colors.yellow[700],
                  )
                ],
              ),
            ),
            const DestinationNearbyPlaces(),
          ],
        ),
      ),
    );
  }
}