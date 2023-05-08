import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travela/common/api/userController.dart';

import '../models/trip.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';
import 'package:latlong2/latlong.dart';
import 'package:http_parser/http_parser.dart';

class TripController {
  static Future<Trip?> getTripDetails(int tripID) async {
    Trip? trip;

    try {
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'trips/$tripID/'),
      );

      var data = jsonDecode(response.body);
      trip = Trip.fromJson(data);
    } catch (err) {
      print(err);
    }

    return trip;
  }

  static Future<List<Trip>> getAllTrips() async {
    final auth = FirebaseAuth.instance;

    List<Trip> allTrips = [];

    try {
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/trips/'),
      );

      var data = jsonDecode(response.body);

      for (Map<String, dynamic> tripEntry in data) {
        allTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err) {
      print("hij");
      print(err);
    }

    return allTrips;
  }

  static Future<List<Trip>> getPendingTrips() async {
    final auth = FirebaseAuth.instance;

    List<Trip> allTrips = [];

    try {
      var response = await http.get(
        Uri.http(
            '127.0.0.1:8000', 'users/${auth.currentUser!.email}/pendingTrips/'),
      );

      var data = jsonDecode(response.body);

      for (Map<String, dynamic> tripEntry in data) {
        allTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err) {
      print(err);
    }

    return allTrips;
  }

  static Future<List<Trip>> getPersonalTrips() async {
    final auth = FirebaseAuth.instance;

    List<Trip> personalTrips = [];

    try {
      var response = await http.get(
        Uri.http('127.0.0.1:8000',
            'users/${auth.currentUser!.email}/personalTrips/'),
      );

      var data = jsonDecode(response.body);

      for (Map<String, dynamic> tripEntry in data) {
        personalTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err) {
      print(err);
    }

    return personalTrips;
  }

  static Future<List<Trip>> getGroupTrips() async {
    final auth = FirebaseAuth.instance;

    List<Trip> groupTrips = [];

    try {
      var response = await http.get(
        Uri.http(
            '127.0.0.1:8000', 'users/${auth.currentUser!.email}/groupTrips/'),
      );

      var data = jsonDecode(response.body);

      for (Map<String, dynamic> tripEntry in data) {
        groupTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err) {
      print(err);
    }

    return groupTrips;
  }

  static Future<void> postTrip(Trip trip, LatLng location, XFile? image) async {
    final auth = FirebaseAuth.instance;

    try {
      dynamic data;
      if (image != null) {
        var uri = Uri.http(
            '127.0.0.1:8000', 'users/${auth.currentUser!.email}/trips/');
        var request = http.MultipartRequest('POST', uri)
          ..fields['owner'] = trip.owner
          ..fields['tripName'] = trip.tripName
          ..fields['startDate'] = trip.startDate
          ..fields['endDate'] = trip.endDate
          ..files.add(http.MultipartFile.fromBytes(
              'tripImage', await image!.readAsBytes(),
              contentType: MediaType('image', image.name.split(".")[1]),
              filename: image.name));
        var responseStream = await request.send();

        var response = await http.Response.fromStream(responseStream);

        data = jsonDecode(response.body);
      } else {
        var response = await http.post(
          Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/trips/'),
          body: {
            'owner': trip.owner,
            'tripName': trip.tripName,
            'startDate': trip.startDate,
            'endDate': trip.endDate,
          },
        );

        data = jsonDecode(response.body);
      }

      var startDateTime = DateTime.parse(trip.startDate).toLocal();
      startDateTime = startDateTime.add(Duration(hours: 6));

      var endDateTime = DateTime.parse(trip.startDate).toLocal();
      endDateTime = endDateTime.add(Duration(hours: 18));

      await http.post(
        Uri.http('127.0.0.1:8000', 'trips/${data["id"]}/itineraryEntry/'),
        body: {
          'trip': data["id"].toString(),
          'dateTime': startDateTime.toIso8601String(),
          'description': "Start of Trip",
          'location_latitude': location.latitude.toString(),
          'location_longitude': location.longitude.toString(),
        },
      );

      await http.post(
        Uri.http('127.0.0.1:8000', 'trips/${data["id"]}/itineraryEntry/'),
        body: {
          'trip': data["id"].toString(),
          'dateTime': endDateTime.toIso8601String(),
          'description': "End of Trip",
          'location_latitude': location.latitude.toString(),
          'location_longitude': location.longitude.toString(),
        },
      );
    } catch (err) {
      print(err);
    }
  }

  static Future<void> shareTrip(Trip trip, BuildContext context) async {
    try {
      String result = await showDialog(
        context: context,
        builder: (ctx) {
          return _ShareDialog(ctx: ctx, name: trip.tripName);
        },
      );
      final auth = FirebaseAuth.instance;

      if (!(trip.pendingUsers.contains(result) ||
          trip.sharedUsers.contains(result) ||
          trip.owner == result ||
          result == auth.currentUser!.email)) {
        Map<String, dynamic> body = {
          'owner': trip.owner,
          'tripName': trip.tripName,
          'startDate': trip.startDate,
          'endDate': trip.endDate,
          'pendingUsers': trip.pendingUsers..add(result),
          'sharedUsers': trip.sharedUsers,
        };

        var response = await http.put(
          Uri.http('127.0.0.1:8000', 'trips/${trip.tripID}/'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode(body),
        );

        if (response.statusCode == 400) {
          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("User does not exist."),
              ),
            );
          }
        }
      } else {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(trip.pendingUsers.contains(result)
                  ? "User already pending."
                  : trip.sharedUsers.contains(result)
                      ? "User already shared."
                      : trip.owner == result
                          ? "Can't share to the owner."
                          : "Can't share to yourself."),
            ),
          );
        }
      }
    } catch (err) {
      print(err);
    }
  }

  // acceptTrip, remove user from pending list, add to shared list
  static Future<void> acceptTrip(Trip trip) async {
    final auth = FirebaseAuth.instance;

    try {
      Map<String, dynamic> body = {
        'owner': trip.owner,
        'tripName': trip.tripName,
        'startDate': trip.startDate,
        'endDate': trip.endDate,
        'pendingUsers': trip.pendingUsers..remove(auth.currentUser!.email),
        'sharedUsers': trip.sharedUsers..add(auth.currentUser!.email!),
      };

      await http.put(
        Uri.http('127.0.0.1:8000', 'trips/${trip.tripID}/'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(body),
      );
    } catch (err) {
      print(err);
    }
  }

  // declineTrip, remove user from pending list
  static Future<void> declineTrip(Trip trip) async {
    final auth = FirebaseAuth.instance;

    try {
      Map<String, dynamic> body = {
        'owner': trip.owner,
        'tripName': trip.tripName,
        'startDate': trip.startDate,
        'endDate': trip.endDate,
        'pendingUsers': trip.pendingUsers..remove(auth.currentUser!.email),
        'sharedUsers': trip.sharedUsers,
      };

      await http.put(
        Uri.http('127.0.0.1:8000', 'trips/${trip.tripID}/'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(body),
      );
    } catch (err) {
      print(err);
    }
  }

  static Future<void> deleteTrip(int tripID, BuildContext context) async {
    try {
      await http.delete(
        Uri.http('127.0.0.1:8000', 'trips/$tripID/'),
      );
    } catch (err) {
      print(err);
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Trip has been deleted'),
      ),
    );
  }
}

class _ShareDialog extends StatefulWidget {
  const _ShareDialog({Key? key, required this.ctx, required this.name})
      : super(key: key);

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
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                    contentPadding: EdgeInsets.zero,
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
