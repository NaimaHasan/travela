import 'package:flutter/material.dart';
import 'package:travela/screens/edit_information/widgets/edit_information_name.dart';
import 'package:travela/screens/edit_information/widgets/edit_information_password.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:travela/screens/new_trip/widgets/new_trip_date.dart';

class NewTripScreenDesktop extends StatelessWidget {
  const NewTripScreenDesktop({
  super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 120,
          width: 420,
          child: Card(
            elevation: 5,
            //color: Colors.black12,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'New Trip',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                  ),
                ),
                Container(
                  height: 30,
                ),
                NewTripDate(title: 'Start Date', data: 'Mar 19, 2023'),
                Container(
                  height: 30,
                ),
                NewTripDate(title: 'End Date', data: 'Mar 23, 2023'),
                Container(
                  height: 30,
                ),
                EditInformationPassword(title: 'Password', data: '********'),
                const Padding(
                  padding: EdgeInsets.only(left: 50, top: 30, bottom: 30),
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
                  height: 60,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {},
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
