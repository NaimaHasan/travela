import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/trip.dart';
import 'package:http/http.dart' as http;

class TripController {
  static Future<List<Trip>> getAllTrips() async {
    List<Trip> allTrips = [];

    var response = await http.get(
      Uri.http('127.0.0.1:8000', 'users/lalala/trips/'),
    );

    var data = jsonDecode(response.body);

    for (Map<String, dynamic> tripEntry in data) {
      allTrips.add(Trip.fromJson(tripEntry));
    }

    // allTrips.forEach((element) {print(element);});

    return allTrips;
  }
}
