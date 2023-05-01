import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:travela/common/api/userController.dart';

import '../models/trip.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class TripController {
  static Future<List<Trip>> getAllTrips() async {
    final auth = FirebaseAuth.instance;

    List<Trip> allTrips = [];

    var response = await http.get(
      Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/trips/'),
    );

    var data = jsonDecode(response.body);

    try {
      for (Map<String, dynamic> tripEntry in data) {
        allTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err) {
      print(err);
    }

    return allTrips;
  }

  static Future<List<Trip>> getPendingTrips() async {
    final auth = FirebaseAuth.instance;

    List<Trip> allTrips = [];

    var response = await http.get(
      Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/pendingTrips/'),
    );

    var data = jsonDecode(response.body);

    try {
      for (Map<String, dynamic> tripEntry in data) {
        allTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err) {
      print(err);
    }

    return allTrips;
  }

  static Future<List<Trip>> getPersonalTrips() async {
    List<Trip> allTrips = await getAllTrips();

    List<Trip> personalTrips = [];

    for (Trip trip in allTrips) {
      if (trip.sharedUsers.isEmpty) {
        personalTrips.add(trip);
      }
    }

    return personalTrips;
  }

  static Future<List<Trip>> getGroupTrips() async {
    List<Trip> allTrips = await getAllTrips();

    List<Trip> groupTrips = [];

    for (Trip trip in allTrips) {
      if (trip.sharedUsers.isNotEmpty) {
        groupTrips.add(trip);
      }
    }

    return groupTrips;
  }

  static Future<void> postTrip(Trip trip) async {
    final auth = FirebaseAuth.instance;

    await http.post(
      Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/trips/'),
      body: {
        'owner': trip.owner,
        'tripName': trip.tripName,
        'startDate': trip.startDate,
        'endDate': trip.endDate,
      },
    );
  }

  static Future<void> shareTrip(
      Trip trip, BuildContext context) async {
    String result = await showDialog(
      context: context,
      builder: (ctx) {
        return _ShareDialog(ctx: ctx, name: trip.tripName,);
      },
    );

    try {
      Map<String, dynamic> body = {
        'owner': trip.owner,
        'tripName': trip.tripName,
        'startDate': trip.startDate,
        'endDate': trip.endDate,
        'pendingUsers': trip.pendingUsers..add(result),
      };

      await http.put(
        Uri.http('127.0.0.1:8000', 'trips/${trip.tripID}/'),
        headers: {
          'content-type': 'application/json'
        },
        body: jsonEncode(body),
      );
    } catch (err) {
      print(err);
    }
  }

  // acceptTrip, remove user from pending list, add to shared list

  // declineTrip, remove user from pending list
}

class _ShareDialog extends StatefulWidget {
  const _ShareDialog({Key? key, required this.ctx, required this.name}) : super(key: key);

  final BuildContext ctx;
  final String name;

  @override
  State<_ShareDialog> createState() => _ShareDialogState();
}

class _ShareDialogState extends State<_ShareDialog> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      contentPadding: EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Share \"${widget.name}\"",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 418,
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(widget.ctx, _controller.text);
                },
                child: Text("Done"),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
