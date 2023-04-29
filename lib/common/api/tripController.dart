import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/trip.dart';
import 'package:http/http.dart' as http;

class TripController {
  static Future<List<Trip>> getAllTrips() async {
    List<Trip> allTrips = [];

    print("ho");

    var response = await http.get(
      Uri.http('127.0.0.1:8000', 'users/lalala/trips/'),
    );

    var data = jsonDecode(response.body);

    print(data);

    try {
      for (Map<String, dynamic> tripEntry in data) {
        allTrips.add(Trip.fromJson(tripEntry));
      }
    } catch (err){
      print(err);
    }

    print(allTrips);

    allTrips.forEach((element) {print(element);});

    return allTrips;
  }

  static Future<void> postTrip(Trip trip) async {
    await http.post(
      Uri.http('127.0.0.1:8000', 'users/lalala/trips/'),
      body: {
        'owner': trip.owner,
        'tripName': trip.tripName,
        'startDate' : trip.startDate,
        'endDate' : trip.endDate,
      },
    );
  }
}
