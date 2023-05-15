import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:travela/screens/new_trip/widgets/new_trip_form.dart';

import '../models/trip.dart';
import 'package:http/http.dart' as http;

import 'package:latlong2/latlong.dart';
import 'package:http_parser/http_parser.dart';

class TripController {
  //Function to get trip details
  static Future<Trip?> getTripDetails(int tripID) async {
    Trip? trip;

    try {
      //Gets the trip detail given the tripID
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'trips/$tripID/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);
      trip = Trip.fromJson(data);
    } catch (err) {
      print(err);
    }

    return trip;
  }

  //Function to get all trips
  static Future<List<Trip>> getAllTrips() async {
    final auth = FirebaseAuth.instance;

    List<Trip> allTrips = [];

    try {
      //Gets all trips of the current user
      var response = await http.get(
        Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/trips/'),
      );

      //Stores the response body in data variable
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

  //Function to get pending trips
  static Future<List<Trip>> getPendingTrips() async {
    final auth = FirebaseAuth.instance;

    List<Trip> allTrips = [];

    try {
      //Gets pending trips of the current user
      var response = await http.get(
        Uri.http(
            '127.0.0.1:8000', 'users/${auth.currentUser!.email}/pendingTrips/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);

      for (Map<String, dynamic> tripEntry in data) {
        allTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err) {
      print(err);
    }

    return allTrips;
  }

  //Function to get personal trips
  static Future<List<Trip>> getPersonalTrips() async {
    final auth = FirebaseAuth.instance;

    List<Trip> personalTrips = [];

    try {
      //Gets personal trips of the current user
      var response = await http.get(
        Uri.http('127.0.0.1:8000',
            'users/${auth.currentUser!.email}/personalTrips/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);

      for (Map<String, dynamic> tripEntry in data) {
        personalTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err) {
      print(err);
    }

    return personalTrips;
  }

  //Function to get group trips
  static Future<List<Trip>> getGroupTrips() async {
    final auth = FirebaseAuth.instance;

    List<Trip> groupTrips = [];

    try {
      //Gets group trips of the current user
      var response = await http.get(
        Uri.http(
            '127.0.0.1:8000', 'users/${auth.currentUser!.email}/groupTrips/'),
      );

      //Stores the response body in data variable
      var data = jsonDecode(response.body);

      for (Map<String, dynamic> tripEntry in data) {
        groupTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err) {
      print(err);
    }

    return groupTrips;
  }

  //Function to post trip
  static Future<void> postTrip(Trip trip, LatLng location, XFile? image) async {
    final auth = FirebaseAuth.instance;

    try {
      dynamic data;
      if (image != null) {
        //Post trip when the user adds an image with the trip
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

        //Stores the response body in data variable
        data = jsonDecode(response.body);
      } else {
        //Post trip when the user does not attach an image with the trip
        var response = await http.post(
          Uri.http('127.0.0.1:8000', 'users/${auth.currentUser!.email}/trips/'),
          body: {
            'owner': trip.owner,
            'tripName': trip.tripName,
            'startDate': trip.startDate,
            'endDate': trip.endDate,
          },
        );

        //Stores the response body in data variable
        data = jsonDecode(response.body);
      }

      var startDateTime = DateTime.parse(trip.startDate).toLocal();
      startDateTime = startDateTime.add(Duration(hours: 6));

      var endDateTime = DateTime.parse(trip.startDate).toLocal();
      endDateTime = endDateTime.add(Duration(hours: 18));

      //http post for the start time and end time of the trip
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

  //Function to edit trip
  static Future<void> putTrip(Trip trip, BuildContext context) async {
    try {
      //Calls showDialogue which returns the NewTripForm
      await showDialog(
        context: context,
        builder: (ctx) {
          return SimpleDialog(children: [NewTripForm(existingTrip: trip)]);
        },
      );
    } catch (err) {
      print(err);
    }
  }

  //Function to share trip
  static Future<void> shareTrip(Trip trip, BuildContext context) async {
    try {
      String result = await showDialog(
        context: context,
        builder: (ctx) {
          //Calls the _ShareDialogue
          return _ShareDialog(ctx: ctx, name: trip.tripName);
        },
      );
      final auth = FirebaseAuth.instance;

      //If the shared user email is not already in the pending list or shared trip list or is not the owner of the trip or the current user
      //then the trip is shared to the user with the email
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

        //Adds the trip to the users pending list
        var response = await http.put(
          Uri.http('127.0.0.1:8000', 'trips/${trip.tripID}/'),
          headers: {'content-type': 'application/json'},
          body: jsonEncode(body),
        );

        //If user could not be found shows error message that the user does not exist
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
        //Shows the respective messages for each of the above mentioned cases
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

  //acceptTrip, remove user from pending list, add to shared list
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

      //If the trip is accepted adds the trip to grouptrip list and removes the trip from pending trip
      await http.put(
        Uri.http('127.0.0.1:8000', 'trips/${trip.tripID}/'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(body),
      );
    } catch (err) {
      print(err);
    }
  }

  //declineTrip, remove user from pending list
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

      //If the trip is declined removes the trip from pending trip
      await http.put(
        Uri.http('127.0.0.1:8000', 'trips/${trip.tripID}/'),
        headers: {'content-type': 'application/json'},
        body: jsonEncode(body),
      );
    } catch (err) {
      print(err);
    }
  }

  //Function to delete trip
  static Future<void> deleteTrip(Trip trip, BuildContext context) async {
    try {
      final auth = FirebaseAuth.instance;
      if(trip.owner == auth.currentUser!.email!) {
        //Deletes the trip from backend
        await http.delete(
          Uri.http('127.0.0.1:8000', 'trips/${trip.tripID}/'),
        );
      }
      else {
        if(trip.pendingUsers.contains(auth.currentUser!.email!)){
          Map<String, dynamic> body = {
            'owner': trip.owner,
            'tripName': trip.tripName,
            'startDate': trip.startDate,
            'endDate': trip.endDate,
            'pendingUsers': trip.pendingUsers..remove(auth.currentUser!.email),
            'sharedUsers': trip.sharedUsers,
          };

          //If the trip is declined removes the trip from pending trip
          await http.put(
            Uri.http('127.0.0.1:8000', 'trips/${trip.tripID}/'),
            headers: {'content-type': 'application/json'},
            body: jsonEncode(body),
          );
        }
        else if(trip.sharedUsers.contains(auth.currentUser!.email!)){
          Map<String, dynamic> body = {
            'owner': trip.owner,
            'tripName': trip.tripName,
            'startDate': trip.startDate,
            'endDate': trip.endDate,
            'pendingUsers': trip.pendingUsers,
            'sharedUsers': trip.sharedUsers..remove(auth.currentUser!.email),
          };

          //If the trip is declined removes the trip from pending trip
          await http.put(
            Uri.http('127.0.0.1:8000', 'trips/${trip.tripID}/'),
            headers: {'content-type': 'application/json'},
            body: jsonEncode(body),
          );
        }
      }
    } catch (err) {
      print(err);
    }
    //Shows snackbar that the trip has been deleted
    if(context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Trip has been deleted'),
        ),
      );
    }
  }
}

//A stateful class for share dialogue
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
      contentPadding: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Text for the heading of the simple dialogue
            Text(
              "Share \"${widget.name}\"",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 418,
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.bottomRight,
              //Elevated button with Done written on it
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(widget.ctx, _controller.text);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Done"),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
