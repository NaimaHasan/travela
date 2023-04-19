import 'package:flutter/material.dart';
import 'package:travela/screens/edit_information/widgets/edit_information_name.dart';
import 'package:travela/screens/edit_information/widgets/edit_information_password.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:travela/screens/new_trip/widgets/new_trip_date.dart';
import 'package:travela/screens/new_trip/widgets/new_trip_location.dart';
import 'package:travela/screens/trip/trip_screen.dart';

import '../../widgets/common/top_navigation_bar.dart';

class NewTripScreenDesktop extends StatelessWidget {
  const NewTripScreenDesktop({
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
        ),
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 120,
          width: 420,
          child: Card(
            elevation: 5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'New Trip',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                NewTripDate(title: 'Start Date', data: 'Mar 19, 2023'),
                NewTripDate(title: 'End Date', data: 'Mar 23, 2023'),
                const Padding(
                  padding: EdgeInsets.only(left: 30, top: 20, bottom: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Location',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                NewTripLocation(data: 'Madeira'),
                const Padding(
                  padding: EdgeInsets.only(left: 30, top: 25, bottom: 15),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Image',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                DottedBorder(
                  borderType: BorderType.RRect,
                  radius: Radius.circular(6),
                  color: Colors.black,
                  dashPattern: [8, 4],
                  strokeWidth: 0.5,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(6),
                    ),
                    child: Container(
                      height: 250,
                      width: 340,
                      child: Center(
                        child: IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.add_photo_alternate_outlined),
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 40,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(TripScreen.routeName);
                    },
                    child: const Text(
                      'Done',
                      style: TextStyle(),
                    ),
                  ),
                ),
                Container(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
