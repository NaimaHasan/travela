import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:travela/screens/account/account_screen.dart';

import 'new_trip_date.dart';
import 'new_trip_location.dart';

class NewTripForm extends StatefulWidget {
  const NewTripForm({Key? key}) : super(key: key);

  @override
  State<NewTripForm> createState() => _NewTripFormState();
}

class _NewTripFormState extends State<NewTripForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(height: 30),
          const Text(
            'New Trip',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          NewTripDate(title: 'Start Date'),
          NewTripDate(title: 'End Date'),
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
          NewTripLocation(),
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
                Navigator.of(context).pushNamed(AccountScreen.routeName);
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
    );
  }
}
